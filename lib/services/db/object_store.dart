import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'object_store_contract.dart';

/// Concrete implementation for local hive data provider
class ObjectStore implements ObjectStoreContract {
  bool _initialized = false;

  ObjectStore() {
    _databaseInit();
  }

  /// Open Hive connection
  Future<void> _databaseInit() async {
    if (!_initialized) {
      await Hive.initFlutter();
      _initialized = true;
    }
  }

  /// Open and return hive box
  Future<Box> _getBox(String boxName) async {
    if (!_initialized) await _databaseInit();

    Box box;
    if (!Hive.isBoxOpen(boxName)) {
      box = await Hive.openBox(boxName);
    } else {
      box = Hive.box(boxName);
    }

    return box;
  }

  @override
  Future insertObjects(
    String boxName,
    Map<String, dynamic> values,
  ) async {
    var box = await _getBox(boxName);
    if (values.isNotEmpty) {
      values.forEach((key, value) {
        box.put(key, value);
      });
    }
  }

  Future<Box> readObject(String boxName) async {
    return await _getBox(boxName);
  }

  @override
  Future<List<Map<String, dynamic>>> readObjects(
    String boxName, {
    List<String>? keys,
  }) async {
    var box = await _getBox(boxName);
    // return all data from box
    if (keys == null || keys.isEmpty) {
      return [Map<String, dynamic>.from(box.toMap())];
    }

    var data = <String, dynamic>{};
    for (var key in keys) {
      data[key] = box.get(key);
    }
    return [data];
  }

  @override
  Future updateObjects(
    String boxName,
    Map<String, dynamic> values,
  ) async {
    var box = await _getBox(boxName);
    if (values.isNotEmpty) {
      values.forEach((key, value) {
        box.put(key, value);
      });
    }
  }

  @override
  Future deleteObjects(
    String boxName, {
    List<String>? keys,
  }) async {
    var box = await _getBox(boxName);

    // empty box
    if (keys == null || keys.isEmpty) {
      await box.clear();
      return;
    }

    await Future.wait(keys.map((key) => box.delete(key)));
    for (var key in keys) {
      await box.delete(key);
    }
  }

  @override
  Future<bool> clearBox(String boxName) async {
    try {
      var box = await _getBox(boxName);
      await box.clear();
    } on Exception {
      return false;
    }
    return true;
  }
}
