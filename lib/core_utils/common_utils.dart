import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../resources/strings/app_translations.dart';

class CommonUtils {
  /// direct copy of 'package:flutter/foundation.dart' so that no need to import it
  static String describeEnum(Object enumEntry) {
    final description = enumEntry.toString();
    final indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  static String enumName(String enumToString) {
    var paths = enumToString.split('.');
    return paths[paths.length - 1];
  }
}

extension StringX on String {
  bool containsIgnoreCase(String stringToMatch) {
    return toLowerCase().contains(stringToMatch.toLowerCase());
  }

  bool hasValidData() {
    return trim().isNotEmpty;
  }

  String getSafeData() {
    return hasValidData() ? this : '';
  }

  bool get isNullOrEmpty => !hasValidData();

  Iterable<String> toIterable() sync* {
    for (var i = 0; i < length; i++) {
      yield (this[i]);
    }
  }

  /// Same as contains, but allows for case insensitive searching
  ///
  /// [caseInsensitive] defaults to false
  bool containsX(String string, {bool caseInsensitive = false}) {
    if (caseInsensitive) {
      // match even if case doesn't match
      return toLowerCase().contains(string.toLowerCase());
    } else {
      return contains(string);
    }
  }

  String substringUntil(Pattern occurrence) {
    final index = indexOf(occurrence);
    if (index == -1) {
      return this;
    }
    return substring(0, index);
  }

  String toLowerCaseNoSpaces() => toLowerCase().replaceAll(' ', '');
}

extension ListEmptyValidation<E> on Iterable<E> {
  bool hasData() => isNotEmpty;
}

String getLNPayloadString(
    String notificationDomain, Map<String, dynamic> data) {
  var domain = {
    'name': notificationDomain,
    'data': data,
  };
  var _mapResponse = <String, dynamic>{
    'notification_domain': Platform.isIOS ? notificationDomain : domain,
    'data': json.encode(data)
  };
  return json.encode(_mapResponse);
}

/// return null if Email is valid
String? validateEmail(String email) {
  if (email.isEmpty) {
    return Translations.getInstance
        .text(Translations.kEmailCannotBeEmpty);
  }
  var isValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!isValid) {
    return Translations.getInstance
        .text(Translations.kInvalidEmailId);
  }
  return null;
}

/// return null if Password is valid
String? validatePassword(String password) {
  if (password.length < 8) {
    return Translations.getInstance
        .text(Translations.kPasswordLengthWarning);
  }
  return null;
}

///show internet dialog
void showConnectionDialog({
  required bool isInternetAvailable,
  required BuildContext context,
}) {
  if (!isInternetAvailable) {
    ///Handle No internet Connection case
  }
}


/// function to get properly comma separated currency from
/// non-comma separated numerical string
String getFormattedCurrency(String? price) {
  if (price == null) {
    return '0';
  }
  try {
    var formattedAmount =
    NumberFormat('#,##,###.##').format(double.parse(price));
    return formattedAmount;
  } on Exception catch (exception) {
    print(exception);
    return price;
  }
}