import 'dart:core';

import '../../resources/values/api_endpoints.dart';
import '../../services/api/service_manager.dart';

import 'access_token_interceptor.dart';

class Repository {
  //Uncomment all usages and import required files when using this repo
  // ApiClient? _apiClient;
  
  ///flag to check whether to add interceptor or not
  bool enableInterceptor = false;

  Repository({this.enableInterceptor = false}) {
    var dioClient = ServiceManager.get().getDioClient(baseUrl: Apis.kBaseUrl);

    /// Add interceptor if flag set
    if(enableInterceptor){
      dioClient.interceptors.add(AccessTokenInterceptor(dioClient));
    }
    // _apiClient = ApiClient(dioClient);

    /// Code to add Api caching
    /// need dio_cache_interceptor package
    /// need dio_cache_interceptor_hive_store
    /// package for using HiveCacheStore()

    // final options = CacheOptions(
    //   store: MemCacheStore() //or HiveCacheStore(null)  ,
    //   policy: CachePolicy.request,
    //   hitCacheOnErrorExcept: [401, 403, 404],
    //   maxStale: const Duration(days: 7),
    //   priority: CachePriority.normal,
    //   cipher: null,
    //   keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    //   allowPostMethod: false,
    // );
    // var dioClient =
    //     ServiceManager.get().getDioClient(baseUrl: Apis.kBaseUrl);
    // dioClient.interceptors.add(DioCacheInterceptor(options: options));
  }

  /// Example for Repo function

  // Future<ApiResponseWrapper<RemoveSocialLoginResponse>> removeSocialLogin(String password,String token) async {
  //   try {
  //     var removeRequest = RemoveSocialRequest(password);
  //     var response = await _apiClient!.removeSocialLogin(token, removeRequest);
  //     return ApiResponseWrapper()..setData(response);
  //   } on Exception catch (error) {
  //     return ApiResponseWrapper()..setException(ExceptionHandler(error));
  //   }
  // }
}
