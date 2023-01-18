import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../settings.dart';

class ServerRepositoryImpl implements ServerRepository {
  final ServerApiDataSource apiDataSource;
  final ServerLocalDataSource localDataSource;

  ServerRepositoryImpl({
    required this.apiDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, CheckServerModel>> getSereverStatus(
      String endpoint, BaseUrlSchema schema) async {
    try {
      final result = await apiDataSource.getServerStatus(endpoint, schema);
      localDataSource.setSavedServerInfo(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, bool>> setSavedServerInfo(
      CheckServerModel server) async {
    try {
      final result = await localDataSource.setSavedServerInfo(server);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CheckServerModel?>> getSavedServerInfo() async {
    try {
      final result = await localDataSource.getSavedServerInfo();

      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeSavedServerInfo() async {
    try {
      final result = await localDataSource.removeServerInfo();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    }
  }
}
