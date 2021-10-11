///Code for biometric Authentication

// import 'package:flutter/services.dart';
// import 'package:local_auth/auth_strings.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:northladder/resources/strings/app_translations.dart';

// // ignore: avoid_classes_with_only_static_members
// class LocalAuthApi {
//   static final _auth = LocalAuthentication();

//   static Future<bool> hasBiometrics() async {
//     try {
//       return await _auth.canCheckBiometrics;
//     } on PlatformException {
//       return false;
//     }
//   }

//   static Future<bool> authenticate() async {
//     final isAvailable = await hasBiometrics();
//     if (!isAvailable) {
//       return false;
//     }
//     try {
//       return await _auth.authenticate(
//         androidAuthStrings: AndroidAuthMessages(
//           signInTitle: Translations.getInstance.text(
//             Translations.kBiometricsRequired,
//           )!,
//         ),
//         biometricOnly: true,
//         localizedReason: Translations.getInstance.text(
//           Translations.kScanFaceORFingerprintToAuthenticate,
//         )!,
//         useErrorDialogs: true,
//         stickyAuth: true,
//       );
//     } on PlatformException catch (_) {
//       return false;
//     }
//   }
// }
