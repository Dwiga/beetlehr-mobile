import 'package:dependencies/dependencies.dart';
import 'package:flutter/foundation.dart';

/// Cache Manager
/// A interface which is used to persist and retrieve state changes.
///
/// Simple and easy management cache, fast, and powerfull
///
/// Only support type data:
///
/// `List`, `Map`, `DateTime`, `BigInt` and `Uint8List`
///
/// **Feature**
/// * Reading cache
/// * Writing cache
/// * Deleting cache
abstract class CacheManager {
  /// Return value from a [key] Param
  ///
  dynamic read(String key);

  /// Presists key value pair
  ///
  /// In write mode only support:
  ///
  /// `List`, `Map`, `DateTime`, `BigInt` and `Uint8List`
  ///
  /// When you write, otherwise can **Error**
  Future<void> write(String key, dynamic value);

  /// Deletes value by key
  Future<void> delete(String key);

  /// Clears all cache from storage
  Future<void> clearAll();
}

/// Key Cache manager box
// ignore: constant_identifier_names
const String CACHE_MANAGER_BOX_KEY = 'LOCAL_DB';

/// Implementation of [CacheManager] which uses `PathProvider` and `dart.io`
/// to persist and retrieve state changes from the local device.
class CacheManagerImpl implements CacheManager {
  static final CacheManagerImpl _instance = CacheManagerImpl._internal();
  static late Box _box;

  CacheManagerImpl._internal();

  /// Get instance Cache manager
  ///
  /// For example when instance null, then instance to be initialize
  /// When not null, return current instance
  ///
  /// When [encript] is true, all data is encript.
  /// By default [encript] is [true]
  ///
  /// Param [encryptKey] for key encript data, by default value is
  /// ['AlOp7lBkcFRdJnXFkGcBHwM9I9TJMMgr']
  ///
  /// [encryptKey] must more than 32, and <= 225

  static Future<CacheManagerImpl> setup({
    bool encrypt = true,
    String encryptKey = 'AlOp7lBkcFRdJnXFkGcBHwM9I9TJMMgr',
  }) async {
    if (!kIsWeb) {
      final path = await getApplicationDocumentsDirectory();
      Hive.init(path.path);
    }
    var _encryptionKey = encryptKey.codeUnits;
    _box = await Hive.openBox(
      CACHE_MANAGER_BOX_KEY,
      encryptionCipher: encrypt ? HiveAesCipher(_encryptionKey) : null,
    );

    return _instance;
  }

  @override
  Future<void> clearAll() async {
    if (_box.isOpen) {
      await _box.deleteFromDisk();
    }
    return;
  }

  @override
  Future<void> delete(String key) async {
    return _box.isOpen ? _box.delete(key) : null;
  }

  @override
  dynamic read(String key) {
    return _box.isOpen ? _box.get(key) : null;
  }

  @override
  Future<void> write(String key, dynamic value) async {
    return _box.isOpen ? _box.put(key, value) : null;
  }
}
