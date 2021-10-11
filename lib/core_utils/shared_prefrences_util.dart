
abstract class SharePreferenceKey {
  static const String appLang = 'appLanguage';
}

class SharePreferenceData {
  static final SharePreferenceData _userData = SharePreferenceData._internal();

  factory SharePreferenceData() {
    return _userData;
  }

  SharePreferenceData._internal();

  /// Example Function
  // Future<void> setAppLanguage({required bool value}) async {
  //   var preferences = await SharedPreferences.getInstance();
  //   await preferences.setBool(SharePreferenceKey.appLang, value);
  // }

  // Future<String> getUserFullName() async {
  //   var preferences = await SharedPreferences.getInstance();
  //   return preferences.getString(SharePreferenceKey.userFullName) ?? '';
  // }

}
