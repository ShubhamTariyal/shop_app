import 'package:flutter/material.dart';

import 'device_info_dialog.dart';
import 'flavor_config.dart';

// ignore: must_be_immutable
class FlavorBanner extends StatelessWidget {
  final Widget child;
  BannerConfig? bannerConfig;
  bool showBanner = false;

  FlavorBanner({required this.child, this.showBanner = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FlavorConfig.isProduction()) return child;

    if (!showBanner) return child;

    if (!FlavorConfig.instance.isDebug) return child;

    bannerConfig ??= _getDefaultBanner();

    return Stack(
      children: <Widget>[child, _buildBanner(context)],
    );
  }

  BannerConfig _getDefaultBanner() => BannerConfig(
      bannerName: FlavorConfig.instance.name,
      bannerColor: FlavorConfig.instance.color);

  Widget _buildBanner(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          width: 50,
          height: 50,
          child: CustomPaint(
            painter: BannerPainter(
                message: bannerConfig?.bannerName ?? 'def',
                textDirection: Directionality.of(context),
                layoutDirection: Directionality.of(context),
                location: BannerLocation.topStart,
                color: bannerConfig?.bannerColor ?? Colors.red),
          ),
        ),
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => const DeviceInfoDialog());
        },
      );
}

class BannerConfig {
  final String bannerName;
  final Color bannerColor;

  BannerConfig({required this.bannerName, required this.bannerColor});
}
