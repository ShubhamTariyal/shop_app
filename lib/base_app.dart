import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';

import 'core_utils/log_util.dart';
import 'resources/strings/app_localization_delegate.dart';
import 'resources/strings/app_translations.dart';
import 'services/config/flavor_banner.dart';
import 'services/config/flavor_config.dart';

void baseAppSetup() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));

  // Run the application under run zoned, to catch unhandled exceptions
  await runZonedGuarded<Future<Null>>(() async {
    LogUtil().printLog(message: 'Showing main');
    runApp(_App());
  }, (error, stackTrace) async {
    // Whenever an error occurs, call the `reportCrash` function. This will send
    // Dart errors to our dev console or Crashlytics depending on the environment.
    // await FirebaseCrashlytics.instance.recordError(error, stackTrace);
    LogUtil().printLog(
        tag: 'Main', message: 'runZonedGuarded exception: $stackTrace');
  });
}

void _configureLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    if (FlavorConfig.instance.isDebug) {
      print(
          '[${rec.level.name}][${rec.time}][${rec.loggerName}]: ${rec.message}');
    }
  });
}

class _AppProviders extends StatelessWidget {
  final Widget child;

  const _AppProviders({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
    ///Add RepositoryProvider(s) and BlocProvider(s) here
    // return MultiRepositoryProvider(
    //   providers: [],
    //   child: MultiBlocProvider(
    //     providers: [],
    //     child: child,
    //   ),
    // );
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);
  static final mainNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return _AppProviders(
      child: MaterialApp(
        home: FlavorBanner(
          showBanner: kDebugMode,
          ///Put your HomePage widget here
          child: Scaffold(
            body: SafeArea(
              child: Center(
                child: Text('Hello World'),
              ),
            ),
          ),
        ),
        navigatorKey: mainNavigatorKey,
        debugShowCheckedModeBanner: false,
        // routes: Routes.routes,
        supportedLocales: [
          Locale(Translations.kLanguageEnglish),
          Locale(Translations.kLanguageArabic),
        ],
        localizationsDelegates: [
          // A class which loads the translations
          const ApplicationLocalizationDelegate(),
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
          // Built-in localization of basic text for Cupertino widgets
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
