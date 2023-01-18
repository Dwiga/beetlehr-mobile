import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiDataSource apiDataSource;

  ProfileRepositoryImpl(this.apiDataSource);
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final result = await apiDataSource.getProfile();

      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
      ProfileBodyModel body) async {
    try {
      final dataBody = await body.toFormData();
      final result = await apiDataSource.updateProfile(dataBody);

      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }
}
