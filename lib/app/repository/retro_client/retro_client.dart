import 'package:dio/dio.dart';

import 'package:retrofit/http.dart';

part 'retro_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(
    Dio dio,
  ) {
    return _ApiClient(dio);
  }

///Examples for GET, POST, PUT and DELETE requests

//   @GET(Apis.kNewOrderRefrence)
//   Future<NewOrderReference> newOrderRefrenceApi(
//       @Header('Authorization') String token);

//   @POST('${Apis.kPickupAddress}')
//   Future<PostAddressModel> saveAddress(@Header('Authorization') String token,
    //   @Body() SaveAddressModel addressDataModel);

//   @DELETE('${Apis.kPickupAddress}/{addressId}')
//   Future<DeleteAddressResponse> deleteAddress(
//     @Header('Authorization') String token,
//     @Path('addressId') String addressId,
//   );

//   @PUT('${Apis.kPickupAddress}/{addressId}')
//   Future<EditAddressResponseModel> editAddress(
//       @Path('addressId') String addressId,
//       @Header('Authorization') String token,
//       @Body() SaveAddressModel addressDataModel);

}
