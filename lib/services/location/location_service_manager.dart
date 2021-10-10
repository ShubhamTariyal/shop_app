import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core_utils/common_utils.dart';
import '../../core_utils/log_util.dart';
import 'repo/location_repository_contract.dart';
import 'repo/model/location_model.dart';

enum _LocationServiceEnum { location, geolocator }

extension _LocationServiceEnumMixin on _LocationServiceEnum {
  String getName() {
    return toString().split('.').last;
  }
}

class LocationServiceManager {
  static bool mock = false;
  static SharedPreferences? prefs;
  static bool isInitialized = false;
  static Location? _location;
  static Position? _currentLocation;
  static LocationRepositoryContract? _locationRepository;
  static LocationAddressModel? _currentLocationAddressModel;
  // static LocationCredentials? _locationCredentials;

  static const _kLocation = 'Location';
  static const _kLastKnownLocation = 'LastKnownLocation';

  static final _LocationServiceEnum _defaultService = Platform.isIOS
      ? _LocationServiceEnum.geolocator
      : _LocationServiceEnum.location;

  // ignore: close_sinks
  static final _currentLocationController =
      StreamController<LocationAddressModel>.broadcast();

  static Stream<LocationAddressModel> get currentLocationStream =>
      _currentLocationController.stream;

  LocationServiceManager._();

  static Future<void> _saveLastKnownLocation(
      LocationAddressModel? model) async {
    prefs ??= await SharedPreferences.getInstance();
    if (model != null) {
      var data = model.toJsonString();
      if (data != null && data.hasValidData()) {
        await prefs!.setString(_kLastKnownLocation, data);
      }
    }
  }

  static Future<LocationAddressModel?> getLastKnownLocation(
      String domainName) async {
    prefs ??= await SharedPreferences.getInstance();
    LocationAddressModel? model;
    var data = prefs!.getString(_kLastKnownLocation);
    if (data != null && data.hasValidData()) {
      model = LocationAddressModel.fromJsonString(data);
    }
    if (model != null) {
      LocationExtras.locationDeviceLogLocation(
        domainName: domainName,
        isLastKnownLocation: true,
        model: model,
        pluginName: _defaultService.getName(),
      );
    }
    return model;
  }

  static Future initialize() async {
    if (mock || isInitialized) {
      return;
    }
    try {
      if (!mock) {
        prefs = await SharedPreferences.getInstance();
      }
      _location = Location();
      if (_defaultService == _LocationServiceEnum.geolocator) {
        _listenGeoLocationChange();
      } else {
        _listenLocationChange();
      }
      // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      //   // Got a new connectivity status!
      //   switch (result) {
      //     case ConnectivityResult.wifi:
      //     case ConnectivityResult.mobile:
      //       getCurrentLocation('Connectivity change');
      //       break;
      //     case ConnectivityResult.none:
      //     default:
      //       break;
      //   }
      // });
      isInitialized = true;
      LogUtil().printLog(message: 'isInitialized: $isInitialized');
    } on Exception catch (e) {
      print('Error initializing LocalStorage ${e.toString()}');
    }
  }

  static void _listenLocationChange() {
    _location?.onLocationChanged.listen((LocationData? updatedLocation) {
      _currentLocation = _getPositionModel(updatedLocation) ?? _currentLocation;
    });
  }

  static void _listenGeoLocationChange() {
    Geolocator.getPositionStream().listen((Position? position) {
      _currentLocation = position ?? _currentLocation;
    });
  }

  // TODO initialise repo and remove null
  static LocationRepositoryContract? getLocationRepository() {
    return _locationRepository;
  }

  static Future<bool> setLocation() async {
    if (!isInitialized) {
      await initialize();
    }
    try {
      return await _setLocationToLocalStorage();
    } on Exception catch (e) {
      print('error in location $e');
      return false;
    }
  }

  static Future<LocationAddressModel> getCurrentLocation(
    String domainName, {
    bool needLatLngOnly = false,
    bool isExtraInfoNeeded = true,
  }) async {
    var isLatLngUpdated = false;
    if (!isInitialized) {
      var model = await getLastKnownLocation(domainName);
      if (model != null) {
        return model;
      }
    }
    if (_currentLocation != null && _currentLocationAddressModel != null) {
      if (_currentLocationAddressModel!.latitude != null &&
          _currentLocationAddressModel!.longitude != null) {
        if (_currentLocationAddressModel!.latitude !=
                _currentLocation!.latitude &&
            _currentLocationAddressModel!.longitude !=
                _currentLocation!.longitude) {
          var dist = Geolocator.distanceBetween(
              _currentLocation!.latitude,
              _currentLocation!.longitude,
              _currentLocationAddressModel!.latitude!,
              _currentLocationAddressModel!.longitude!);
          if (dist > 500) {
            isLatLngUpdated = true;
          }
        }
      }
    }

    if (_currentLocationAddressModel != null &&
        !_currentLocationAddressModel!.isAddressModelValidated) {
      _currentLocationAddressModel = null;
    }

    if (_currentLocationAddressModel == null || isLatLngUpdated) {
      // in case of any issue with current location, replace it with _getLocationOld();
      var addressModel = await _getLocation();
      if (!needLatLngOnly) {
        addressModel = await getLocationRepository()!.validateLocation(
            addressModel, domainName,
            isExtraInfoNeeded: isExtraInfoNeeded);
      } else {
        LocationExtras.locationDeviceLog(
            pluginName: _defaultService.getName(),
            domainName: domainName,
            message: 'Only lat lng is requested');
        return addressModel;
      }
      _currentLocationAddressModel = addressModel;
      isLatLngUpdated = false;
      if (_currentLocationAddressModel!.isAddressModelValidated) {
        // ignore: unawaited_futures
        _saveLastKnownLocation(_currentLocationAddressModel);
        try {
          _currentLocationController.sink.add(_currentLocationAddressModel!);
        } on Exception catch (e) {
          LogUtil().printLog(message: e.toString());
        }
      }
      LocationExtras.locationDeviceLogLocation(
        pluginName: _defaultService.getName(),
        domainName: domainName,
        model: _currentLocationAddressModel,
      );
      LocationExtras.locationDeviceLog(
          pluginName: _defaultService.getName(),
          domainName: domainName,
          message: 'current location is refetched');
    }
    LocationExtras.locationDeviceLog(
        pluginName: _defaultService.getName(),
        domainName: domainName,
        message: 'current location is requested');
    return _currentLocationAddressModel!;
  }

  static Future<LocationAddressModel> _getLocation() async {
    try {
      var loc = _currentLocation;
      if (loc != null) {
        return LocationAddressModel(
          latitude: loc.latitude,
          longitude: loc.longitude,
        );
      } else {
        return _getLocationOld();
      }
    } on Exception {
      return _getLocationOld();
    }
  }

  static Future<LocationAddressModel> _getLocationOld() async {
    var prefLocation = prefs!.getString(_kLocation);
    LocationAddressModel location;
    if (prefLocation != null) {
      var locationUpdateCheck = json.decode(prefs!.getString(_kLocation) ?? '');
      location = LocationAddressModel(
          latitude: locationUpdateCheck['latitude'],
          longitude: locationUpdateCheck['longitude']);
    } else {
      var setLoc = await _setLocationToLocalStorage();
      if (setLoc) {
        var locationUpdateCheck =
            json.decode(prefs!.getString(_kLocation) ?? '');
        location = LocationAddressModel(
            latitude: locationUpdateCheck['latitude'],
            longitude: locationUpdateCheck['longitude']);
      } else {
        location = LocationAddressModel(
            latitude: 1.3485708236694336, longitude: 103.84122890839899);
      }
    }
    return location;
  }

  static Future<bool> _setLocationToLocalStorage() async {
    try {
      if (!isInitialized) {
        await initialize();
      }
      _currentLocation = _defaultService == _LocationServiceEnum.location
          ? await _locateUser()
          : await _determinePosition();
      // ignore: unawaited_futures
      getCurrentLocation('LocServiceInit');
      final location = {
        'latitude': _currentLocation!.latitude,
        'longitude': _currentLocation!.longitude,
        'timeZone': 'Asia/Singapore', // TODO: Replace this with real data
        'updatedAt': DateTime.now().toIso8601String()
      };

      await prefs!.setString(_kLocation, json.encode(location));
      return true;
    } on Exception catch (e) {
      print('error in location $e');
      return false;
    }
  }

  static Future<Position?> _locateUser() async {
    try {
      bool serviceEnabled;
      PermissionStatus permissionStatus;
      LocationData locationData;

      serviceEnabled = await _location!.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location!.requestService();
        if (!serviceEnabled) {
          throw Exception('Failed to enable location service');
        }
      }

      permissionStatus = await _location!.hasPermission();

      ///TODO: (deprecated)
      /// it wont return [PermissionStatus.deniedForever] We need to update location library to version 4.0.0 and above
      /// In order to update, the required dart sdk is 2.12 (Flutter 2.0)
      /// All the developers need to update to flutter 2.0
      if (permissionStatus == PermissionStatus.deniedForever) {
        throw Exception('Please enable location from settings');
      }

      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await _location!.requestPermission();
        if (permissionStatus != PermissionStatus.granted) {
          throw Exception('Failed to get permission for location');
        }
      }

      locationData = await _location!.getLocation();
      return _getPositionModel(locationData);
    } on Exception catch (e) {
      print('error in location $e');
      rethrow;
    }
  }

  static Position? _getPositionModel(LocationData? locationData) {
    if (locationData != null) {
      return Position(
        latitude: locationData.latitude ?? 0.0,
        longitude: locationData.longitude ?? 0.0,
        timestamp: locationData.time != null
            ? DateTime.fromMicrosecondsSinceEpoch(locationData.time!.round())
            : null,
        accuracy: locationData.accuracy ?? 0.0,
        altitude: locationData.altitude ?? 0.0,
        heading: locationData.heading ?? 0.0,
        speed: locationData.speed ?? 0.0,
        speedAccuracy: locationData.speedAccuracy ?? 0.0,
      );
    } else {
      return null;
    }
  }

  static Future<Position> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      Position position;
      serviceEnabled = await _location!.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location!.requestService();
        if (!serviceEnabled) {
          throw Exception('Failed to enable location service');
        }
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Please enable location from settings');
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          throw Exception(
              'Location permissions are denied (actual value: $permission).');
        }
      }
      position = await Geolocator.getCurrentPosition();
      return position;
    } on Exception catch (e) {
      print('error in location $e');
      rethrow;
    }
  }

  static Future<bool> checkLocationServiceEnabled() async {
    final serviceEnabled = await _location!.serviceEnabled();
    if (serviceEnabled) {
      return true;
    } else {
      return await _location!.requestService();
    }
  }

  static Future<bool> checkLocationPermission() async {
    if (_defaultService == _LocationServiceEnum.location) {
      var status = await _location!.hasPermission();
      switch (status) {
        case PermissionStatus.granted:
          return true;
        case PermissionStatus.deniedForever:
          return false;
        case PermissionStatus.denied:
          status = await _location!.requestPermission();
          return status == PermissionStatus.granted;
        default:
          return false;
      }
    } else {
      var status = await Geolocator.checkPermission();
      switch (status) {
        case LocationPermission.always:
        case LocationPermission.whileInUse:
          return true;
        case LocationPermission.deniedForever:
          return false;
        case LocationPermission.denied:
          status = await Geolocator.requestPermission();
          return status == LocationPermission.always ||
              status == LocationPermission.whileInUse;
        default:
          return false;
      }
    }
  }
}

class LocationExtras {
  static void locationDeviceLog(
      {String? tag, String? domainName, String? message, String? pluginName}) {
    tag ??= 'LocationService';
    domainName ??= 'unknown';
    pluginName ??= 'unknown';
    var description = 'Domain Name -> $domainName ,';
    description += 'Plugin Name -> $pluginName ,';
    description += 'message -> $message';
    if (kDebugMode) {
      LogUtil().printLog(tag: tag, message: description);
    }
  }

  static void locationDeviceLogLocation(
      {String? tag,
      String? domainName,
      LocationAddressModel? model,
      bool isLastKnownLocation = false,
      String? pluginName}) {
    tag ??= 'LocationService';
    domainName ??= 'unknown';
    pluginName ??= 'unknown';
    if (model != null) {
      var map = <String, dynamic>{
        'DomainName': domainName,
        'PluginName': pluginName,
        'isLastKnownLocation': isLastKnownLocation,
      };
      map.addAll(model.toJson());
      var result;
      try {
        result = json.encode(map);
      } on Exception catch (e) {
        LogUtil().printLog(message: e.toString());
        result = map.toString();
      }
      if (kDebugMode) {
        LogUtil().printLog(tag: tag, message: result);
      }
    }
  }
}
