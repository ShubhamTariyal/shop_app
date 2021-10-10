class LocationCredentials {
  String? apiKey;

  LocationCredentials({this.apiKey});

  factory LocationCredentials.fromJson(Map<String, dynamic> srcJson) =>
      LocationCredentials(apiKey: srcJson['apiKey'] as String);

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
    };
  }
}
