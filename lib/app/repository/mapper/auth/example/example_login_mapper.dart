/// Example of Mapper
// import 'package:northladder/app/repository/model/auth/login_model.dart';
// import 'package:northladder/app/repository/response/auth/login_response.dart';

// LoginModel loginMapper(LoginResponse response) {
//   var model = LoginModel(
//     status: response.status!,
//     message: response.message!,
//     data: dataMapper(response.data!),
//   );
//   return model;
// }

// LoginData dataMapper(Data data) {
//   var model = LoginData(
//     token: data.token!,
//     refreshToken: data.refreshToken!,
//     user: userMapper(data.user!),
//   );
//   return model;
// }

// UserData userMapper(User user) {
//   var model = UserData(
//     id: user.id!,
//     firstName: user.firstName,
//     lastName: user.lastName,
//     email: user.email,
//     // userInfo: user.userInfo,
//     emailVerified: user.emailVerified,
//     phoneVerified: user.phoneVerified,
//     userId: user.userId,
//     createdOn: user.createdOn,
//     lastUpdatedOn: user.lastUpdatedOn,
//     lastActiveTime: user.lastActiveTime,
//     userType: user.userType,
//     roles: user.roles,
//     status: user.status,
//     referral: referralInfoMapper(user.referral),
//     currency: user.currency,
//     phoneNo: user.userInfo?.phoneNo,
//     setupAccountToken: user.setupAccountToken,
//     setupTokenActive: user.setupTokenActive,
//     rating: user.rating,
//     dob: user.dob,
//     pickupAddresses: pickupAddressMapper(user.pickupAddresses),
//     addressList: addressMapper(user.addressList),
//     profileImage: user.profileImage,
//   );
//   return model;
// }

// ReferralInfo? referralInfoMapper(Referral? referral) {
//   if (referral != null) {
//     var model = ReferralInfo(
//       referralCode: referral.referralCode!,
//       dealDone: referral.dealDone!,
//     );
//     return model;
//   }
// }

// List<PickupAddressesData>? pickupAddressMapper(
//     List<PickupAddresses>? pickupAddresses) {
//   if (pickupAddresses != null) {
//     var model = <PickupAddressesData>[];
//     var length = pickupAddresses.length;
//     for (var index = 0; index < length; ++index) {
//       model.add(
//         PickupAddressesData(
//           addressTitle: pickupAddresses[index].addressTitle,
//           apartmentOrFlat: pickupAddresses[index].apartmentOrFlat,
//           streetName: pickupAddresses[index].streetName,
//           landmark: pickupAddresses[index].landmark,
//           city: pickupAddresses[index].city,
//           lat: pickupAddresses[index].lat,
//           long: pickupAddresses[index].long,
//           addressId: pickupAddresses[index].addressId,
//         ),
//       );
//     }
//     return model;
//   }
// }

// List<AddressListData>? addressMapper(List<AddressList>? addressList) {
//   if (addressList != null) {
//     var model = <AddressListData>[];
//     var length = addressList.length;
//     for (var index = 0; index < length; ++index) {
//       model.add(
//         AddressListData(
//           id: addressList[index].id,
//           addressTitle: addressList[index].addressTitle,
//           apartmentOrFlat: addressList[index].apartmentOrFlat,
//           streetName: addressList[index].streetName,
//           landmark: addressList[index].landmark,
//           city: addressList[index].city,
//           lat: addressList[index].lat,
//           long: addressList[index].long,
//         ),
//       );
//     }
//     return model;
//   }
// }
