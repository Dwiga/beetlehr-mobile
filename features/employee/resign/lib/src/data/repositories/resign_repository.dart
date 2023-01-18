import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../resign.dart';

class ResignRepositoryImpl implements ResignRepository {
  final ResignApiDataSource apiDataSource;

  ResignRepositoryImpl(this.apiDataSource);
  @override
  Future<Either<Failure, ResignEntity>> createResign(
      ResignBodyModel body) async {
    try {
      final dataBody = await body.toFormData();
      final result = await apiDataSource.createResign(dataBody);

      return Right(result.data!);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, ResignEntity?>> getResign() async {
    try {
      final result = await apiDataSource.getResign();

      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, bool>> cancelResign(int id) async {
    try {
      final result = await apiDataSource.cancelResign(id);

      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }
}
