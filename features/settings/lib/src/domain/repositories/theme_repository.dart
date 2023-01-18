import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:preferences/preferences.dart';

/// Interface ThemeRepository
///
/// Theme data management
abstract class ThemeRepository {
  /// Get theme
  ///
  /// Key [theme] is a from type [AppTheme] enum
  ///
  /// For example:
  /// ```dart
  /// ThemeRepository().setTheme(AppTheme.blueDark);
  /// ```
  Future<Either<Failure, bool>> setTheme(AppTheme theme);

  /// Get saved cache theme,
  ///
  /// Then cache save based from enum [AppTheme] from String data cache
  Future<Either<Failure, AppTheme?>> getTheme();
}
