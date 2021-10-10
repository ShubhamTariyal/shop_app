import 'package:geocoding/geocoding.dart';

/// Contains detailed placemark information.
class CustomPlacemark {
  /// Constructs an instance with the given values for testing. [Placemark]
  /// instances constructed this way won't actually reflect any real information
  /// from the platform, just whatever was passed in at construction time.
  CustomPlacemark(
      {this.name,
      this.isoCountryCode,
      this.country,
      this.postalCode,
      this.administrativeArea,
      this.subAdministrativeArea,
      this.locality,
      this.subLocality,
      this.thoroughfare,
      this.subThoroughfare,
      this.position});

  CustomPlacemark._(
      {this.name,
      this.isoCountryCode,
      this.country,
      this.postalCode,
      this.administrativeArea,
      this.subAdministrativeArea,
      this.locality,
      this.subLocality,
      this.thoroughfare,
      this.subThoroughfare,
      this.position});

  static CustomPlacemark mapGeoPlacemark(
      Placemark placemark, double latitude,double? longitude) {
    return CustomPlacemark(
      name: placemark.name,
      isoCountryCode: placemark.isoCountryCode,
      country: placemark.country,
      postalCode: placemark.postalCode,
      administrativeArea: placemark.administrativeArea,
      subAdministrativeArea: placemark.subAdministrativeArea,
      locality: placemark.locality,
      subLocality: placemark.subLocality,
      thoroughfare: placemark.thoroughfare,
      subThoroughfare: placemark.subThoroughfare,
      position: longitude != null
          ? CustomLocation(latitude: latitude, longitude: longitude)
          : null,
    );
  }

  /// The name of the placemark.
  final String? name;

  /// The abbreviated country name, according to the two letter (alpha-2) [ISO standard](https://www.iso.org/iso-3166-country-codes.html).
  final String? isoCountryCode;

  /// The name of the country associated with the placemark.
  final String? country;

  /// The postal code associated with the placemark.
  final String? postalCode;

  /// The name of the state or province associated with the placemark.
  final String? administrativeArea;

  /// Additional administrative area information for the placemark.
  final String? subAdministrativeArea;

  /// The name of the city associated with the placemark.
  final String? locality;

  /// Additional city-level information for the placemark.
  final String? subLocality;

  /// The street address associated with the placemark.
  final String? thoroughfare;

  /// Additional street address information for the placemark.
  final String? subThoroughfare;

  /// The geocoordinates associated with the placemark.
  final CustomLocation? position;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, type_annotate_public_apis
  bool operator ==(o) =>
      o is CustomPlacemark &&
      o.administrativeArea == administrativeArea &&
      o.country == country &&
      o.isoCountryCode == isoCountryCode &&
      o.locality == locality &&
      o.name == name &&
      o.position == position &&
      o.postalCode == postalCode &&
      o.subAdministrativeArea == subAdministrativeArea &&
      o.subLocality == subLocality &&
      o.subThoroughfare == subThoroughfare &&
      o.thoroughfare == thoroughfare;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode =>
      administrativeArea.hashCode ^
      country.hashCode ^
      isoCountryCode.hashCode ^
      locality.hashCode ^
      name.hashCode ^
      position.hashCode ^
      postalCode.hashCode ^
      subAdministrativeArea.hashCode ^
      subLocality.hashCode ^
      subThoroughfare.hashCode ^
      thoroughfare.hashCode;

  /// Converts a list of [Map] instances to a list of [Placemark] instances.
  static List<CustomPlacemark> fromMaps(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final List<CustomPlacemark> list =
        message.map<CustomPlacemark>(fromMap).toList();
    return list;
  }

  /// Converts the supplied [Map] to an instance of the [Placemark] class.
  static CustomPlacemark fromMap(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final Map<dynamic, dynamic> placemarkMap = message;

    return CustomPlacemark._(
      name: placemarkMap['name'] ?? '',
      isoCountryCode: placemarkMap['isoCountryCode'] ?? '',
      country: placemarkMap['country'] ?? '',
      postalCode: placemarkMap['postalCode'] ?? '',
      administrativeArea: placemarkMap['administrativeArea'] ?? '',
      subAdministrativeArea: placemarkMap['subAdministrativeArea'] ?? '',
      locality: placemarkMap['locality'] ?? '',
      subLocality: placemarkMap['subLocality'] ?? '',
      thoroughfare: placemarkMap['thoroughfare'] ?? '',
      subThoroughfare: placemarkMap['subThoroughfare'] ?? '',
      position: placemarkMap['position'] != null
          ? CustomLocation.fromMap(placemarkMap['position'])
          : null,
    );
  }

  /// Converts the [Placemark] instance into a [Map] instance that can be serialized to JSON.
  Map<String, dynamic> toJson() => {
        'name': name,
        'isoCountryCode': isoCountryCode,
        'country': country,
        'postalCode': postalCode,
        'administrativeArea': administrativeArea,
        'subAdministrativeArea': subAdministrativeArea,
        'locality': locality,
        'subLocality': subLocality,
        'thoroughfare': thoroughfare,
        'subThoroughfare': subThoroughfare,
        'position': position?.toJson()
      };
}

/// Contains detailed location information.
class CustomLocation {
  /// Constructs an instance with the given values for testing. [Location]
  /// instances constructed this way won't actually reflect any real information
  /// from the platform, just whatever was passed in at construction time.
  CustomLocation({
    this.latitude,
    this.longitude,
    this.timestamp,
  });

  CustomLocation._({
    this.latitude,
    this.longitude,
    this.timestamp,
  });

  /// The latitude associated with the placemark.
  final double? latitude;

  /// The longitude associated with the placemark.
  final double? longitude;

  /// The UTC timestamp the coordinates have been requested.
  final DateTime? timestamp;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(dynamic o) =>
      o is CustomLocation &&
      o.latitude == latitude &&
      o.longitude == longitude &&
      o.timestamp == timestamp;

  @override
  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ timestamp.hashCode;

  /// Converts a list of [Map] instances to a list of [Location] instances.
  static List<CustomLocation> fromMaps(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final List<CustomLocation> list =
        message.map<CustomLocation>(fromMap).toList();
    return list;
  }

  /// Converts the supplied [Map] to an instance of the [Location] class.
  static CustomLocation fromMap(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final Map<dynamic, dynamic> locationMap = message;
    final timestamp = locationMap['timestamp'] != null
        ? DateTime.fromMillisecondsSinceEpoch(locationMap['timestamp'].toInt(),
            isUtc: true)
        : null;

    return CustomLocation._(
      latitude: locationMap['latitude'],
      longitude: locationMap['longitude'],
      timestamp: timestamp,
    );
  }

  /// Converts the [Location] instance into a [Map] instance that can be
  /// serialized to JSON.
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp?.millisecondsSinceEpoch,
      };

  @override
  String toString() {
    return '''
      Latitude: $latitude,
      Longitude: $longitude,
      Timestamp: $timestamp''';
  }
}
