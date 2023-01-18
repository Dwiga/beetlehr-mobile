import 'dart:convert';

import 'package:core/core.dart';

import '../../../settings.dart';

/// Interface
abstract class SettingLocalDataSource {
  /// Save cache to DB
  /// Param [theme] is base from enum [AppTheme]
  ///
  /// For example when you save theme blueDark
  ///
  /// ```dart
  /// setCacheTheme(AppThemeConverter.convertToString(AppTheme.blueDark))
  /// ```
  Future<bool> setCacheTheme(String theme);

  /// Get saved cache from DB
  ///
  /// Return is [String] when data is not empty or null
  ///
  /// Return [String] from [AppTheme] enum convert to String
  ///
  /// Then you must convert again to enum
  Future<String> getCacheTheme();

  /// Set default local language
  /// in param [country] must not be null
  Future<bool> setCacheLanguage(CountryModel country);

  Future<CountryModel> getCacheLanguage();

  Future<String?> getBaseURL();

  Future<bool> setBaseURL(String url);

  Future<bool> deleteBaseURL();
}

/// Implementing class [SettingLocalDataSource]
class SettingLocalDataSourceImpl extends SettingLocalDataSource {
  /// [CacheManager] when use implementation class
  ///
  /// Use should use [CacheManagerImpl] class
  ///
  /// Then when use [get_it], this more example:
  ///
  /// ```dart
  /// SettingLocalDataSourceImpl(
  ///   cacheManager: getIt<CacheManager>()
  /// )
  /// ```
  final CacheManager cacheManager;

  /// Param [cacheManager] is required,
  ///
  /// And param [cacheManager] can't be null
  SettingLocalDataSourceImpl({
    required this.cacheManager,
  });

  @override
  Future<String> getCacheTheme() async {
    final _result = await cacheManager.read(SettingConfig.themeCacheKey);
    if (_result != null) {
      return _result;
    }
    throw const NotFoundCacheException(message: 'Theme Cache Not Found');
  }

  @override
  Future<bool> setCacheTheme(String theme) async {
    try {
      await cacheManager.write(SettingConfig.themeCacheKey, theme);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> setCacheLanguage(CountryModel country) async {
    try {
      await cacheManager.write(
          SettingConfig.languageCacheKey, json.encode(country.toJson()));
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<CountryModel> getCacheLanguage() async {
    try {
      final _result = await cacheManager.read(SettingConfig.languageCacheKey);
      if (_result != null) {
        return CountryModel.fromJson(json.decode(_result));
      }
      throw const NotFoundCacheException(message: 'Language Cache Not Found');
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<String?> getBaseURL() async {
    try {
      final _result = await cacheManager.read(SettingConfig.baseURLCacheKey);
      return _result;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> setBaseURL(String url) async {
    try {
      await cacheManager.write(SettingConfig.baseURLCacheKey, url);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> deleteBaseURL() async {
    try {
      await cacheManager.delete(SettingConfig.baseURLCacheKey);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
