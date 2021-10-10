import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import '../../core_utils/common_utils.dart';

import 'device_utils.dart';
import 'flavor_config.dart';

class DeviceInfoDialog extends StatelessWidget {
  DeviceInfoDialog();

  @override
  Widget build(BuildContext context) => AlertDialog(
      contentPadding: EdgeInsets.only(bottom: 10.0),
      title: Container(
        padding: EdgeInsets.all(15.0),
        color: FlavorConfig.instance.color,
        child: Text(
          'Device Info',
          style: TextStyle(color: Colors.white),
        ),
      ),
      titlePadding: EdgeInsets.all(0),
      content: _getContent(),
    );

  Widget _getContent() {
    if (Platform.isAndroid) {
      return _androidContent();
    }

    if (Platform.isIOS) {
      return _iOSContent();
    }

    return Text("You're not on Android neither iOS");
  }

  Widget _iOSContent() => FutureBuilder(
        future: DeviceUtils.iosDeviceInfo(),
        builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
          if (!snapshot.hasData) return Container();

          var device = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTile('Flavor:', '${FlavorConfig.instance.name}'),
                _buildTile('Build mode:',
                    '${CommonUtils.enumName(DeviceUtils.currentBuildMode().toString())}'),
                _buildTile('Physical device?:', '${device?.isPhysicalDevice}'),
                _buildTile('Device:', '${device?.name}'),
                _buildTile('Model:', '${device?.model}'),
                _buildTile('System name:', '${device?.systemName}'),
                _buildTile('System version:', '${device?.systemVersion}')
              ],
            ),
          );
        });

  Widget _androidContent() => FutureBuilder(
        future: DeviceUtils.androidDeviceInfo(),
        builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
          if (!snapshot.hasData) return Container();

          var device = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTile('Flavor:', '${FlavorConfig.instance.name}'),
                _buildTile('Build mode:',
                    '${CommonUtils.enumName(DeviceUtils.currentBuildMode().toString())}'),
                _buildTile('Physical device?:', '${device?.isPhysicalDevice}'),
                _buildTile('Manufacturer:', '${device?.manufacturer}'),
                _buildTile('Model:', '${device?.model}'),
                _buildTile('Android version:', '${device?.version.release}'),
                _buildTile('Android SDK:', '${device?.version.sdkInt}')
              ],
            ),
          );
        });

  Widget _buildTile(String key, String value) => Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Text(
            key,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value)
        ],
      ),
    );
}
