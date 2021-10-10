
import 'model/location_model.dart';

abstract class LocationRepositoryContract {
  Future<List<LocationAddressModel>> getCity(
      String searchParam, String domainName);

  Future<List<LocationAddressModel>> getCustomGeocode(
    String searchParam,
    String domainName, {
    String language = 'en',
  });

  Future<List<LocationAddressModel>> getCustomRevGeocode(
    double lat,
    double lng,
    String domainName, {
    String language = 'en',
  });

  Future<List<LocationAddressModel>> getAddressList(
    String searchParam,
    String domainName, {
    String sessionToken,
    num offset,
    num radius,
    String language,
    String types,
    bool strictbounds,
    String components,
    String region,
    double latitude,
    double longitude,
    LocationSearchEnum locationEnum,
  });

  Future<LocationAddressModel> validateLocation(
    LocationAddressModel locationAddressModel,
    String domainName, {
    bool isExtraInfoNeeded = false,
    bool preferLocationAddressFirst = false,
  });

  Future<List<LocationAddressModel>> validateLocationList(
    List<LocationAddressModel> locationAddressModel,
    String domainName, {
    bool preferLocationAddressFirst = false,
  });

  Future<List<LocationAddressModel>> getRecentAddressList();

  Future<bool> saveRecentAddress(LocationAddressModel model);

  Future<List<LocationAddressModel>> getSavedAddressList();

  Future<bool> saveAddress(LocationAddressModel model);

  Future<bool> deleteListOfSavedAddress(List<int> indexList);

  Future<bool> deleteSavedAddress(int index);

  Future<bool> editSavedAddress(int index, LocationAddressModel addressModel);
}
