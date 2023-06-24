import 'dart:async';

import 'package:hive/hive.dart';

class LocalStorage {
  static final Box _db = Hive.box("app_data");

  static FutureOr<dynamic> get(String key) async {
    try {
      final data = await _db.get(key);

      return data;
    } catch (e) {
      return null;
    }
  }

  static FutureOr<bool> put(String key, dynamic value) async {
    try {
      await _db.put(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static FutureOr<bool> putItems(Map<String, dynamic> data) async {
    try {
      await _db.putAll(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static FutureOr<bool> clearDB() async {
    try {
      await _db.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  static FutureOr<bool> removeItem(String key) async {
    try {
      await _db.delete(key);
      return true;
    } catch (e) {
      return false;
    }
  }
}