import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../leave.dart';

class LeaveRepositoryImpl implements LeaveRepository {
  final LeaveApiDataSource apiDataSource;
  LeaveRepositoryImpl({
    required this.apiDataSource,
  });
  @override
  Future<Either<Failure, LeaveResponseModel>> getLeaves(
      {required bool isComplete,
      required int page,
      required int perPage}) async {
    try {
      final result = await apiDataSource.getLeaves(
        isComplete: isComplete,
        page: page,
        perPage: perPage,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, LeaveDetailEntity>> getDetailLeave(int id) async {
    try {
      final result = await apiDataSource.getDetailLeave(id);
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, PaginateData<List<LeaveTypeEntity>, MetaData>>>
      getLeaveType({required int page, required int perPage}) async {
    try {
      final result = await apiDataSource.getLeaveType(
        page: page,
        perPage: perPage,
      );
      return Right(
        PaginateData(
          data: result.data,
          meta: result.meta,
        ),
      );
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, bool>> createLeave(LeaveBodyModel body) async {
    try {
      final result = await apiDataSource.createLeave(await body.toFormData());
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, bool>> cancelLeave(int id) async {
    try {
      final result = await apiDataSource.cancelLeave(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }
}
