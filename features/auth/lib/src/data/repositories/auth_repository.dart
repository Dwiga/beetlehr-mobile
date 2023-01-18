import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../auth.dart';

/// Implementation [AuthRepository]
class AuthRepositoryImpl implements AuthRepository {
  /// Data Source API
  final AuthApiDataSource apiDataSource;

  /// Local Data Source
  final AuthLocalDataSource localDataSource;

  /// All field must not null
  AuthRepositoryImpl({
    required this.apiDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> loginWithEmail(
      Map<String, dynamic> jsonBody) async {
    try {
      final result = await apiDataSource.loginWithEmail(jsonBody);
      localDataSource.setSavedUser(result.user);
      localDataSource.setToken(result.token);
      return Right(result.user);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, String>> getSavedToken() async {
    try {
      final result = await localDataSource.getToken();
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
  Future<Either<Failure, UserEntity>> getSavedUser() async {
    try {
      final result = await localDataSource.getSavedUser();

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
  Future<Either<Failure, bool>> resetPassword(String email) async {
    try {
      final result = await apiDataSource.resetPasswordEmail(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    final deleteToken = await localDataSource.removeToken();
    final deleteUser = await localDataSource.removeSavedUser();

    if (deleteToken && deleteUser) {
      return const Right(true);
    }
    return const Left(CacheFailure(message: ''));
  }

  @override
  Future<Either<Failure, bool>> setSavedUser(UserModel user) async {
    try {
      final result = await localDataSource.setSavedUser(user);
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
}
