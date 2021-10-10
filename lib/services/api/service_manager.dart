import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ServiceManager {
  static ServiceManager? _serviceManager;

  // App BaseUrl
  String? _baseUrl;

  //Is Debug Mode
  late bool _isDebug;

  // ignore: prefer_final_fields
  HashMap<String, String> _defaultHeaders = HashMap();

  static void init(
      {@required String? baseUrl,
      @required bool? isDebug,
      HashMap<String, String>? defaultHeaders}) {
    _serviceManager ??= ServiceManager._instance(
          baseUrl: baseUrl,
          isDebug: isDebug ?? false,
          defaultHeaders: defaultHeaders);
  }

  ServiceManager._instance(
      {@required String? baseUrl,
        bool isDebug = false,
      HashMap<String, String>? defaultHeaders}) {
    _baseUrl = baseUrl;
    _isDebug = isDebug;
    if (defaultHeaders != null && defaultHeaders.isNotEmpty) {
      _defaultHeaders.addAll(defaultHeaders);
    }
  }

  static ServiceManager get() {
    if (_serviceManager == null) {
      throw Exception('Method not initialised');
    }
    return _serviceManager!;
  }

  Dio getDioClient(
      {String? baseUrl,
      HashMap<String, String>? moreHeaders,
      HashMap<String, dynamic>? cacheManager}) {
    final dio = Dio();

    var hashMap = HashMap<String, String>();
    hashMap['Content-Type'] = 'application/json; charset=utf-8';
    hashMap['Accept'] = 'application/json; charset=utf-8';

    dio
      ..options.baseUrl = _baseUrl ?? ''
      ..options
          .headers
          .addAll(hashMap);
    if (baseUrl != null && baseUrl.trim().isNotEmpty) {
      dio.options.baseUrl = baseUrl.trim();
    }
    if (_defaultHeaders.isNotEmpty) {
      dio.options.headers.addAll(_defaultHeaders);
    }
    if (moreHeaders != null && moreHeaders.isNotEmpty) {
      dio.options.headers.addAll(moreHeaders);
    }

    // if (cacheManager != null && cacheManager.isNotEmpty) {
    //   dio.options.extra.addAll(cacheManager);
    //   dio.interceptors.add(
    //       DioCacheManager(CacheConfig(baseUrl: dio.options.baseUrl))
    //           .interceptor);
    // }

    if (_isDebug) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }
    return dio;
  }
}
