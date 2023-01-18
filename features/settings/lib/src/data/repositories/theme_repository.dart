import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:preferences/preferences.dart';

import '../../../settings.dart';

/// Implementation class ThemeRepository
class ThemeRepositoryImpl extends ThemeRepository {
  /// [SettingLocalDataSource]
  final SettingLocalDataSource localDataSource;

  /// Params [localDataSource] is required and must not 'null'
  ThemeRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AppTheme?>> getTheme() async {
    try {
      final _result = await localDataSource.getCacheTheme();
      return Right(AppThemeConverter.fromString(_result));
    } on CacheException catch (e) {
      return Left(CacheFailure(
        message: e.message,
        code: e.code,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> setTheme(AppTheme theme) async {
    try {
      final result = await localDataSource
          .setCacheTheme(AppThemeConverter.convertToString(theme));
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(
        message: e.message,
        code: e.code,
      ));
    }
  }
}
