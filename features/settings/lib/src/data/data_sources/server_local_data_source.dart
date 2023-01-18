import 'dart:convert';
import 'package:core/core.dart';
import 'package:settings/settings.dart';

abstract class ServerLocalDataSource {
  Future<CheckServerModel> getSavedServerInfo();

  Future<bool> setSavedServerInfo(CheckServerModel user);

  Future<bool> removeServerInfo();
}

class ServerLocalDataSourceImpl implements ServerLocalDataSource {
  final CacheManager cacheManager;

  ServerLocalDataSourceImpl({required this.cacheManager});

  @override
  Future<CheckServerModel> getSavedServerInfo() async {
    final result = await cacheManager.read(SettingConfig.urlServerCacheKey);
    if (result != null) {
      return CheckServerModel.fromJson(json.decode(result));
    }
    throw const NotFoundCacheException(message: 'Server Cache Not Found');
  }

  @override
  Future<bool> setSavedServerInfo(CheckServerModel server) async {
    try {
      await cacheManager.write(
          SettingConfig.urlServerCacheKey, json.encode(server.toJson()));
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> removeServerInfo() async {
    await cacheManager.delete(SettingConfig.urlServerCacheKey);
    return true;
  }
}
