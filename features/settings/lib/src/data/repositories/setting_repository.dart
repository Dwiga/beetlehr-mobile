import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../settings.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingApiDataSource apiDataSource;
  final SettingLocalDataSource localDataSource;

  SettingRepositoryImpl({
    required this.apiDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> saveToken(String token) async {
    try {
      final result = await apiDataSource.saveToken(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, Uri?>> getBaseURL() async {
    try {
      final result = await localDataSource.getBaseURL();
      if ((result ?? '').isEmpty) {
        return const Left(CacheFailure(message: 'Cache Not Found'));
      }
      return Right(Uri.tryParse(result!));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> setBaseURL(Uri uri) async {
    try {
      final result = await localDataSource.setBaseURL(uri.toString());
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBaseURL() async {
    try {
      final result = await localDataSource.deleteBaseURL();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    }
  }
}
