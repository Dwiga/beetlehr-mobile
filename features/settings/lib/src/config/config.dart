import '../../settings.dart';

/// All config from [SettingModule]
class SettingConfig {
  SettingConfig._();

  /// KEY cache data saved theme
  static const String themeCacheKey = 'theme cache';

  /// KEY cache data save language
  static const String languageCacheKey = 'language cache';

  /// KEY cache data save url
  static const String urlServerCacheKey = 'base url cache';

  static const String baseURLCacheKey = 'KRANEE_BASE_URL_CACHE';

  static Country defaultCountry = CountryData.supportedCountry.first;
}
