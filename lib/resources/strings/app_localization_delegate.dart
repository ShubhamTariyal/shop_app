import 'package:flutter/widgets.dart';

import 'app_translations.dart';

class ApplicationLocalizationDelegate
    extends LocalizationsDelegate<Translations> {
  const ApplicationLocalizationDelegate();

  ///list of supported locales
  @override
  bool isSupported(Locale locale) => [
        Translations.kLanguageEnglish,
        Translations.kLanguageArabic
      ].contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate old) => false;

  @override
  Future<Translations> load(Locale locale) async {
    var localizations = Translations.getInstance;
    localizations.setLocale(locale);
    await localizations.load();
    return localizations;
  }
}