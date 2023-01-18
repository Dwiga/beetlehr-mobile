import 'dart:convert';

import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
/// Load configuration global
class GlobalConfiguration {
  static final GlobalConfiguration _singleton = GlobalConfiguration._internal();

  GlobalConfiguration._internal();

  ///
  /// Loading a configuration [map] into the current app config.
  ///
  static Map<String, dynamic> _appConfig = {};

  /// Get value config
  T getValue<T>(String key) => _appConfig[key] as T;

  /// Load data config from `assets`
  /// Params `path` is path assets
  ///
  /// And file must be, extensions `.json`
  static Future<GlobalConfiguration> setup(String path) async {
    var config = await rootBundle.loadString(path);
    Map<String, dynamic> configMap = json.decode(config);
    _appConfig = configMap;

    return _singleton;
  }

  /// Set value global configuration cache
  ///
  /// It this can save your data until close an App.
  /// Because [setValue] is set value in a variable [Map]
  void setValue(String key, dynamic value) {
    _appConfig.putIfAbsent(key, () => value);
  }
}
