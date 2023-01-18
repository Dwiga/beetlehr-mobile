import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../settings.dart';

/// Interface LanguageRepository
///
/// Language data management
abstract class LanguageRepository {
  /// Set current language
  Future<Either<Failure, bool>> setLanguage(CountryModel country);

  /// Get saved cache Language,
  ///
  /// Then cache save based from enum [AppLanguage] from String data cache
  Future<Either<Failure, Country>> getLanguage();
}
