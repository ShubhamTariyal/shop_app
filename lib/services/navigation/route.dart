import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    /// Navigation with arguments
    // case EnumRoute.orderSummary:
    //   return MaterialPageRoute(
    //       settings: settings,
    //       builder: (context) =>
    //           OrderSummary(settings.arguments as OrderSummaryModel));

    /// Custom Navigation
    // case EnumRoute.pageName:
    //   return customNavigation(page: PageName());

    /// Navigation with arguments
    // case EnumRoute.invoiceDownloadPage:
    //   return customNavigation(page: InvoiceDownloadPage(settings.arguments as String));

    /// Handling when path not found
    default:
      return customNavigation(
        page: Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRouteBuilder customNavigation({
  Widget? page,
  bool isHorizontalDirection = true,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page!,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = isHorizontalDirection ? Offset(1.0, 0.0) : Offset(0.0, -1.0);
      const end = Offset.zero;
      const curve = Curves.decelerate;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}



PageRouteBuilder electronicFlowNavigation({
  Widget? page,
  bool isHorizontalDirection = true,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page!,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = isHorizontalDirection ? Offset(0.0, 0.0) : Offset(0.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.linear;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
