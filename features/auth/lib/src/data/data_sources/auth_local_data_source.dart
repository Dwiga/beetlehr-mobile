import 'dart:convert';

import 'package:core/core.dart';

import '../../../auth.dart';

///
abstract class AuthLocalDataSource {
  ///
  Future<String> getToken();

  ///
  Future<bool> setToken(String token);

  Future<bool> removeToken();

  ///
  Future<UserModel> getSavedUser();

  ///
  Future<bool> setSavedUser(UserModel user);

  Future<bool> removeSavedUser();
}

///
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  /// cache manager
  final CacheManager cacheManager;

  /// Cache manager must not be null
  AuthLocalDataSourceImpl(this.cacheManager);

  @override
  Future<UserModel> getSavedUser() async {
    final result = await cacheManager.read(AuthConfig.userCacheKey);
    if (result != null) {
      return UserModel.fromJson(json.decode(result));
    }
    throw const NotFoundCacheException(message: 'User Cache Not Found');
  }

  @override
  Future<String> getToken() async {
    final result = await cacheManager.read(AuthConfig.tokenCacheKey);
    if (result != null) return result;
    throw const NotFoundCacheException(message: 'Token Cache Not Found');
  }

  @override
  Future<bool> setSavedUser(UserModel user) async {
    try {
      await cacheManager.write(
          AuthConfig.userCacheKey, json.encode(user.toJson()));
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> setToken(String token) async {
    await cacheManager.write(AuthConfig.tokenCacheKey, token);
    return true;
  }

  @override
  Future<bool> removeSavedUser() async {
    await cacheManager.delete(AuthConfig.userCacheKey);
    return true;
  }

  @override
  Future<bool> removeToken() async {
    await cacheManager.delete(AuthConfig.tokenCacheKey);
    return true;
  }
}
