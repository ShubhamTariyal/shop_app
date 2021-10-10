import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic data}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: data);
  }

  Future<dynamic> popAndPush(String routeName, {dynamic data}) {
    return navigatorKey.currentState!
        .popAndPushNamed(routeName, arguments: data);
  }

  Future<dynamic> pushAndRemoveUntil(String routeName, String deletionRoute,
      {dynamic data}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(deletionRoute),
        arguments: data);
  }

  void popUntil(String routeDelete) {
    return navigatorKey.currentState!
        .popUntil(ModalRoute.withName(routeDelete));
  }

  void pop({String? value}) {
    return navigatorKey.currentState!.pop(value);
  }
  
}
