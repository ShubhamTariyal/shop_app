import 'package:flutter/material.dart';

import 'base_app.dart';
import 'services/api/service_manager.dart';
import 'services/config/flavor_config.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.dev,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(
          baseUrl: '',
      ));
  ServiceManager.init(
      baseUrl: FlavorConfig.instance.flavorValues.baseUrl,
      isDebug: FlavorConfig.instance.isDebug);
  baseAppSetup();
}