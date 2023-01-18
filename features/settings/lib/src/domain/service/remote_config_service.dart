import 'dart:developer';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

enum AppVersionType { expired, haveUpdate, upToDate }

class RemoteConfigService {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  late Box _box;

  Future<FirebaseRemoteConfig> initialize() async {
    try {
      await _remoteConfig.setDefaults({
        'minimum_app_version': '1',
        'latest_app_version': '1',
        'send_location_duration': '300',
        'base_url_api': GetIt.I<GlobalConfiguration>().getValue('base_url'),
        'apps_store_url': '',
        'play_store_url': '',
      });
      await _fetchAndActivate();
    } catch (e) {
      log('Unable to fetch remote config $e');
    }

    return _remoteConfig;
  }

  Future<RemoteConfigValue?> getValue(String key) async {
    try {
      await _remoteConfig.fetchAndActivate();
      return _remoteConfig.getValue(key);
    } catch (e) {
      return null;
    }
  }

  Future _fetchAndActivate() async {
    try {
      _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 30),
      ));
      await _remoteConfig.fetchAndActivate();
    } catch (e, stackTrace) {
      log('ERROR FETCH REMOTE CONFIG ${e.runtimeType}',
          stackTrace: stackTrace, error: e);
    }
  }

  Future saveBaseURL(String url) async {
    try {
      final defaultValue = GetIt.I<GlobalConfiguration>().getValue('base_url');
      if (url != defaultValue) {
        final _box = await _getBox();
        await _box.put('base_url', url);
      }
    } catch (e) {
      log('ERROR: $e');
    }
  }

  Future<String> getBaseURL() async {
    final _defaultValue = GetIt.I<GlobalConfiguration>().getValue('base_url');
    try {
      final _box = await _getBox();
      return _box.get('base_url') ?? _defaultValue;
    } catch (e) {
      return _defaultValue;
    }
  }

  Future<Box> _getBox() async {
    var isOpenedBox = Hive.isBoxOpen('remote_config');
    if (!isOpenedBox) {
      _box = await Hive.openBox('remote_config');
      return _box;
    } else {
      return _box;
    }
  }

  Future<AppVersionType> checkAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = Utils.intParser(packageInfo.buildNumber);
    final latestVersion =
        Utils.intParser(_remoteConfig.getString('latest_app_version'));
    final minimumVersion =
        Utils.intParser(_remoteConfig.getString('minimum_app_version'));

    log('''
    .......................................................
    .  CURRENT VERSION : $currentVersion                  .
    .  LATEST VERSION  : $latestVersion                 .
    .  MINIMUM VERSION : $minimumVersion                  .
    .......................................................
    ''');

    if (currentVersion != null &&
        latestVersion != null &&
        minimumVersion != null) {
      if (currentVersion < minimumVersion) {
        return AppVersionType.expired;
      } else if (currentVersion < latestVersion) {
        return AppVersionType.haveUpdate;
      }
    }
    return AppVersionType.upToDate;
  }
}
