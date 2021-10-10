import 'package:flutter/material.dart';
import '../../core_utils/common_utils.dart';

enum Flavor { dev, qa, production }

class FlavorValues {
  FlavorValues({
    required this.baseUrl,
  });

  final String baseUrl;
//Add other flavor specific values, e.g database name

}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues flavorValues;
  final bool isDebug = bool.fromEnvironment('dart.vm.product') == false;

  static FlavorConfig? _instance;

  factory FlavorConfig(
      {required Flavor flavor,
      required FlavorValues values,
      Color color = Colors.blue}) {
    _instance ??= FlavorConfig._internal(
        flavor, CommonUtils.enumName(flavor.toString()), color, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.flavorValues);

  static FlavorConfig get instance => _instance!;

  static bool isProduction() => _instance!.flavor == Flavor.production;

  static bool isDevelopment() => _instance!.flavor == Flavor.dev;

  static bool isQA() => _instance!.flavor == Flavor.qa;
}
