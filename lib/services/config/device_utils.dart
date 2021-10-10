
import 'package:device_info/device_info.dart';

enum BuildMode {
  debug,
  profile,
  release
}

class DeviceUtils {

  static BuildMode currentBuildMode() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return BuildMode.release;
    }
    var result = BuildMode.profile;

    //Little trick, since assert only runs on DEBUG mode
    assert(() {
      result = BuildMode.debug;
      return true;
    }());
    return result;
  }
  /// Method to get android device information on which app is running
  static Future<AndroidDeviceInfo> androidDeviceInfo() async {
    var plugin = DeviceInfoPlugin();
    return plugin.androidInfo;
  }

  /// Method to get iOS device information on which app is running
  static Future<IosDeviceInfo> iosDeviceInfo() async {
    var plugin = DeviceInfoPlugin();
    return plugin.iosInfo;
  }

}