
import 'object_store.dart';

/// This will provider the access of [ObjectStore] class,
/// And manage the single instance of [ObjectStore]
class ObjectStoreProvider {
  static ObjectStore? _instance;

  static final ObjectStoreProvider _singleton = ObjectStoreProvider._internal();

  ObjectStoreProvider._internal() {
    _instance ??= ObjectStore();
  }

  factory ObjectStoreProvider() {
    return _singleton;
  }

  ObjectStore getInstance() {
    return _instance!;
  }
}
