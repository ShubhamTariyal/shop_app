import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Translations {
  Locale? locale;

  static Translations? _instance;

  Translations._();

  static Translations get getInstance =>
      _instance = _instance ?? Translations._();

  late Map<String, String> _sentences;

  // ignore: use_setters_to_change_properties
  void setLocale(Locale locale) {
    this.locale = locale;
  }

  Future<bool> load() async {
    _sentences = <String, String>{};
    await _parseJson('${locale?.languageCode}.json');
    return true;
  }

  Future<void> _parseJson(String fileName) async {
    // reading json
    var data = await _loadAsset('locale/i18n_$fileName');
    if (data != null) {
      Map<String, dynamic> _result = json.decode(data);

      // adding values to [_sentences]
      _result.forEach((String key, dynamic value) {
        _sentences[key] = value.toString();
      });
    }
  }

  Future<String?> _loadAsset(String key) async {
    try {
      return await rootBundle.loadString(key);
    } on FlutterError catch (_) {
      return null;
    }
  }

  String? text(String key) {
    if (!_sentences.containsKey(key)) return '$key not found';
    return _sentences[key];
  }

  // Keys
  static const String kLanguageEnglish = 'en';
  static const String kLanguageArabic = 'ar';

  static const String kKeyBrand = 'brand';

  //Warnings
  static const String kEmailCannotBeEmpty = 'Email cannot be empty.';
  static const String kInvalidEmailId = 'Invalid email id.';
  static const String kPasswordLengthWarning =
      'Password must be 8 characters long.';

}
