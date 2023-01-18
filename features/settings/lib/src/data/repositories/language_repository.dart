import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../settings.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final SettingLocalDataSource localDataSource;

  LanguageRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Country>> getLanguage() async {
    try {
      final result = await localDataSource.getCacheLanguage();
      return Right(result);
    } on NotFoundCacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    } on CacheException catch (e) {
      return Left(CacheFailure(
        message: e.message,
        code: e.code,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> setLanguage(CountryModel country) async {
    try {
      final result = await localDataSource.setCacheLanguage(country);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(
        code: e.code,
        message: e.message,
      ));
    }
  }
}
