import 'package:dio/dio.dart';

class AccessTokenInterceptor extends Interceptor {
  Dio dioClient;
  AccessTokenInterceptor(
    this.dioClient,
  );

  @override
  Future onError(
      DioError error, ErrorInterceptorHandler errorInterceptorHandler) async {
    try {
      if (_shouldRetry(error)) {
        // var options = error.response!.requestOptions;

        // If no token, request token firstly and lock this interceptor
        // to prevent other request enter this interceptor.
        dioClient.interceptors.requestLock.lock();
        try {
          
          ///Add handling

          dioClient.interceptors.requestLock.unlock();

          ///Hit api again after handling if required
          // var response = await dioClient.request(
          //   options.path,
          //   data: options.data,
          //   options: Options(
          //     sendTimeout: options.sendTimeout,
          //     method: options.method,
          //     receiveTimeout: options.receiveTimeout,
          //     extra: options.extra,
          //     headers: options.headers,
          //     responseType: options.responseType,
          //     contentType: options.contentType,
          //     validateStatus: options.validateStatus,
          //     receiveDataWhenStatusError: options.receiveDataWhenStatusError,
          //     followRedirects: options.followRedirects,
          //     maxRedirects: options.maxRedirects,
          //     requestEncoder: options.requestEncoder,
          //     responseDecoder: options.responseDecoder,
          //     listFormat: options.listFormat,
          //   ),
          // );

          ///finally mark as resolved
          // errorInterceptorHandler.resolve(response);
        } on Exception catch (_) {
          dioClient.interceptors.requestLock.unlock();
          // tokens are updated, hit request again

          print('Error while RefreshingTokenForGraphApi: ${error.toString()}');
          ///Handle exception

          // if (exception is DioError) {
          //   if (exception.response != null &&
          //       exception.response!.statusCode == 403) {
          //     exception.response?.statusCode = Constants.kTokenErrorStatusCode;
          //     exception.response?.statusMessage =
          //         Constants.kTokenErrorStatusMessage;
          //   }
          //   errorInterceptorHandler.next(exception);
          // } else {
            errorInterceptorHandler.next(error);
          // }
        }
      } else {
        errorInterceptorHandler.next(error);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler requestInterceptorHandler) async {
    ///Add required handling
    // if (_isHeaderTokenEmpty(options.headers[Constants.authHeaderKey])) {
    //
    //   requestInterceptorHandler.next(options);
    // } else {
    //   requestInterceptorHandler.next(options);
    // }
  }

  @override
  void onResponse(Response response,
      ResponseInterceptorHandler responseInterceptorHandler) async {
    responseInterceptorHandler.next(response);
  }

  // bool _isHeaderTokenEmpty(String header) {
  //   return header.trim().isNotEmpty
  //       ? header.trim().toLowerCase().contains('null'.toLowerCase())
  //       : true;
  // }

  bool _shouldRetry(DioError error) {
    return error.error != null && error.response?.statusCode == 401;
  }
}
