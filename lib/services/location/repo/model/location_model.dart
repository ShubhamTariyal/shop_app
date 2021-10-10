import 'dart:convert';

import '../../../../core_utils/common_utils.dart';
import '../../../../core_utils/log_util.dart';

import 'custom_placemark.dart';

enum LocationSearchEnum {
  geocoder,
  custom
}

class LocationAddressModel {
  String? savedName;
  String? locationName;
  String? locationAddress;
  String? locationFullAddress;
  double? latitude;
  double? longitude;
  String? notes;
  String? placesId;
  String? isoCountryCode;
  String? country;
  List<LocationAddressComponents>? _addressComponents;
  MappedAddressComponents? _mappedAddressComponents;
  String? carrefourAreaCode;

  //Data from geocoder and geolocator api
  CustomPlacemark? _geoPlacemark;
  MappedAddressComponents? _mappedGeoPlacemarkComponents; //Temporary use
  // Address? _geoAddress;
  MappedAddressComponents? _mappedGeoAddressComponents; //Temporary use

  LocationAddressModel({
    this.savedName,
    this.locationName,
    this.locationAddress,
    this.locationFullAddress,
    this.latitude,
    this.longitude,
    this.notes,
    this.placesId,
    this.isoCountryCode,
    this.country,
    this.carrefourAreaCode,
  });

  bool get isValidated => country != null;

  void updateAddressComponents(List<LocationAddressComponents>? list) {
    _addressComponents = list;
    if (list != null && list.isNotEmpty) {
      _mappedAddressComponents = MappedAddressComponents(list);
    } else {
      _mappedAddressComponents = null;
    }
  }

  List<LocationAddressComponents>? getAddressComponents() {
    return _addressComponents;
  }

  MappedAddressComponents? getMappedAddressComponents() {
    return _mappedAddressComponents ??
        _mappedGeoPlacemarkComponents ??
        _mappedGeoAddressComponents;
  }

  void updateGeoPlacemark(CustomPlacemark? placemark) {
    _geoPlacemark = placemark;
    if (placemark != null) {
      _mappedGeoPlacemarkComponents =
          MappedAddressComponents.geoPlacemark(placemark);
    } else {
      _mappedGeoPlacemarkComponents = null;
    }
  }

  CustomPlacemark? getGeoPlacemark() {
    return _geoPlacemark;
  }

  // void updateGeoAddress(Address? address) {
  //   _geoAddress = address;
  //   if (address != null) {
  //     _mappedGeoAddressComponents = MappedAddressComponents.geoAddress(address);
  //   } else {
  //     _mappedGeoAddressComponents = null;
  //   }
  // }
  //
  // Address? getGeoAddress() {
  //   return _geoAddress;
  // }

  LocationAddressModel.fromJson(dynamic json) {
    savedName = json['savedName'];
    locationName = json['locationName'];
    locationAddress = json['locationAddress'];
    locationFullAddress = json['locationFullAddress'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    notes = json['notes'];
    placesId = json['placesId'];
    isoCountryCode = json['isoCountryCode'];
    country = json['country'];
    if (json['carrefourAreaCode'] != null) {
      carrefourAreaCode = json['carrefourAreaCode'];
    }
    if (json['locationAddressComponents'] != null) {
      var addressComponents = <LocationAddressComponents>[];
      json['locationAddressComponents'].forEach((v) {
        addressComponents.add(LocationAddressComponents.fromJson(v));
      });
      updateAddressComponents(addressComponents);
    }
  }

  static LocationAddressModel? fromJsonString(String jsonString) {
    if (jsonString.hasValidData()) {
      var map;
      try {
        map = json.decode(jsonString);
      } on Exception catch (e) {
        LogUtil().printLog(tag: 'LocationAddressModel', message: e.toString());
      }
      if (map != null) {
        return LocationAddressModel.fromJson(map);
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['savedName'] = savedName;
    data['locationName'] = locationName;
    data['locationAddress'] = locationAddress;
    data['locationFullAddress'] = locationFullAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['notes'] = notes;
    data['placesId'] = placesId;
    data['isoCountryCode'] = isoCountryCode;
    data['country'] = country;
    data['carrefourAreaCode'] = carrefourAreaCode;
    final addressComponents = getAddressComponents();

    if (addressComponents != null) {
      data['locationAddressComponents'] =
          addressComponents.map((v) => v.toJson()).toList();
    }

    data.removeWhere((key, value) => value == null);
    return data;
  }

  String? toJsonString() {
    final data = toJson();
    try {
      return json.encode(data);
    } on Exception catch (e) {
      LogUtil().printLog(tag: 'LocationAddressModel', message: e.toString());
    }
    return null;
  }

  bool contains(String pattern) {
    final caseInsensitivePattern = RegExp(pattern, caseSensitive: false);
    return (locationName?.contains(caseInsensitivePattern) ?? false) ||
        (locationAddress?.contains(caseInsensitivePattern) ?? false);
  }

  bool get isAddressModelValidated {
    return (locationName?.hasValidData() ?? false) &&
        (locationAddress?.hasValidData() ?? false) &&
        (locationFullAddress?.hasValidData() ?? false) &&
        latitude != null &&
        longitude != null &&
        getMappedAddressComponents() != null;
  }

  String? get city => getMappedAddressComponents()?.locality?.longName;

  String? get postalCode => getMappedAddressComponents()?.postalCode?.longName;

  String? get addressLine1 => getMappedAddressComponents()?.route?.longName;

  String? get state => getMappedAddressComponents()?.adminAreaLvl1?.longName;
}

class LocationAddressComponents {
  String? longName;
  String? shortName;
  List<String>? type;

  LocationAddressComponents({this.longName, this.shortName, this.type});

  LocationAddressComponents.fromJson(dynamic json) {
    longName = json['longName'];
    shortName = json['shortName'];
    type = json['type'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['longName'] = longName;
    data['shortName'] = shortName;
    data['type'] = type;
    return data;
  }
}

class MappedAddressComponents {
  /// The following types are supported and returned by the geocoder in both the
  /// address type and address component type arrays:
  ///
  /// street_address indicates a precise street address.
  ///
  /// route indicates a named route (such as "US 101").
  ///
  /// intersection indicates a major intersection, usually of two major roads.
  /// political indicates a political entity. Usually, this type indicates a
  /// polygon of some civil administration.
  ///
  /// country indicates the national political entity, and is typically the
  /// highest order type returned by the Geocoder.
  ///
  /// administrative_area_level_1 indicates a first-order civil entity below
  /// the country level. Within the United States, these administrative levels
  /// are states. Not all nations exhibit these administrative levels. In most
  /// cases, administrative_area_level_1 short names will closely match
  /// ISO 3166-2 subdivisions and other widely circulated lists; however this
  /// is not guaranteed as our geocoding results are based on a variety of
  /// signals and location data.
  ///
  /// administrative_area_level_2 indicates a second-order civil entity below
  /// the country level. Within the United States, these administrative levels
  /// are counties. Not all nations exhibit these administrative levels.
  ///
  /// administrative_area_level_3 indicates a third-order civil entity below
  /// the country level. This type indicates a minor civil division. Not all
  /// nations exhibit these administrative levels.
  ///
  /// administrative_area_level_4 indicates a fourth-order civil entity below
  /// the country level. This type indicates a minor civil division. Not all
  /// nations exhibit these administrative levels.
  ///
  /// administrative_area_level_5 indicates a fifth-order civil entity below
  /// the country level. This type indicates a minor civil division. Not all
  /// nations exhibit these administrative levels.
  ///
  /// locality indicates an incorporated city or town political entity.
  /// sublocality indicates a first-order civil entity below a locality. For
  /// some locations may receive one of the additional types:
  /// sublocality_level_1 to sublocality_level_5. Each sublocality level is a
  /// civil entity. Larger numbers indicate a smaller geographic area.
  ///
  /// neighborhood indicates a named neighborhood
  /// premise indicates a named location, usually a building or collection of
  /// buildings with a common name
  ///
  /// subpremise indicates a first-order entity below a named location, usually
  /// a singular building within a collection of buildings with a common name
  /// plus_code indicates an encoded location reference, derived from latitude
  /// and longitude. Plus codes can be used as a replacement for street
  /// addresses in places where they do not exist (where buildings are not
  /// numbered or streets are not named). See https://plus.codes for details.
  /// postal_code indicates a postal code as used to address postal mail within
  /// the country.
  static final String _keyPremise = 'premise';
  static final String _keyRoute = 'route';
  static final String _keySubLocalityLvl1 = 'sublocality_level_1';
  static final String _keySubLocalityLvl2 = 'sublocality_level_2';
  static final String _keyLocality = 'locality';
  static final String _keyAdminAreaLvl1 = 'administrative_area_level_1';
  static final String _keyAdminAreaLvl2 = 'administrative_area_level_2';
  static final String _keyCountry = 'country';
  static final String _keyPostalCode = 'postal_code';
  static final String _keyStreetNumber = 'street_number';
  static final String _keyNeighborhood = 'neighborhood';
  static final String _keyPostalTown = 'postal_town';

  LocationAddressComponents? premise;
  LocationAddressComponents? route;
  LocationAddressComponents? neighborhood;
  LocationAddressComponents? subLocalityLvl1;
  LocationAddressComponents? subLocalityLvl2;
  LocationAddressComponents? locality;
  LocationAddressComponents? postalTown;
  LocationAddressComponents? adminAreaLvl1;
  LocationAddressComponents? adminAreaLvl2;
  LocationAddressComponents? country;
  LocationAddressComponents? postalCode;

  MappedAddressComponents(List<LocationAddressComponents?>? list) {
    if (list != null && list.isNotEmpty) {
      for (var data in list) {
        if (data != null && data.type != null && data.type!.isNotEmpty) {
          var type = data.type!;
          if (type.contains(_keyPremise) || type.contains(_keyStreetNumber)) {
            premise = data;
          } else if (type.contains(_keyRoute)) {
            route = data;
          } else if (type.contains(_keyNeighborhood)) {
            neighborhood = data;
          } else if (type.contains(_keySubLocalityLvl1)) {
            subLocalityLvl1 = data;
          } else if (type.contains(_keySubLocalityLvl2)) {
            subLocalityLvl2 = data;
          } else if (type.contains(_keyLocality)) {
            locality = data;
          } else if (type.contains(_keyPostalTown)) {
            postalTown = data;
          } else if (type.contains(_keyAdminAreaLvl1)) {
            adminAreaLvl1 = data;
          } else if (type.contains(_keyAdminAreaLvl2)) {
            adminAreaLvl2 = data;
          } else if (type.contains(_keyCountry)) {
            country = data;
          } else if (type.contains(_keyPostalCode)) {
            postalCode = data;
          }
        }
      }
    }
  }

  LocationAddressComponents? _getCustomComponent(String? data,
      {String? shortName}) {
    if (data != null && data.trim().isNotEmpty) {
      return LocationAddressComponents(
          longName: data.trim(),
          shortName: shortName != null && shortName.trim().isNotEmpty
              ? shortName.trim()
              : data.trim());
    } else {
      return null;
    }
  }

  MappedAddressComponents.geoPlacemark(CustomPlacemark? placemark) {
    if (placemark == null) {
      return;
    }
    premise = _getCustomComponent(placemark.subThoroughfare);
    route = _getCustomComponent(placemark.thoroughfare);
    subLocalityLvl1 = _getCustomComponent(placemark.subLocality);
    locality = _getCustomComponent(placemark.locality);
    adminAreaLvl1 = _getCustomComponent(placemark.administrativeArea);
    adminAreaLvl2 = _getCustomComponent(placemark.subAdministrativeArea);
    country = _getCustomComponent(placemark.country,
        shortName: placemark.isoCountryCode);
    postalCode = _getCustomComponent(placemark.postalCode);
  }

// MappedAddressComponents.geoAddress(Address? address) {
//   if (address == null) {
//     return;
//   }
//   premise = _getCustomComponent(address.subThoroughfare);
//   route = _getCustomComponent(address.thoroughfare);
//   subLocalityLvl1 = _getCustomComponent(address.subLocality);
//   locality = _getCustomComponent(address.locality);
//   adminAreaLvl1 = _getCustomComponent(address.adminArea);
//   adminAreaLvl2 = _getCustomComponent(address.subAdminArea);
//   country = _getCustomComponent(address.countryName,
//       shortName: address.countryCode);
//   postalCode = _getCustomComponent(address.postalCode);
// }
}
