import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../payroll.dart';

class PayrollRepositoryImpl implements PayrollRepository {
  final PayrollApiDataSource apiDataSource;

  PayrollRepositoryImpl(this.apiDataSource);

  @override
  Future<Either<Failure, PaginateData<List<PayrollEntity>, MetaData>>>
      getPayrolls(
          {required int? month,
          required int? year,
          required int page,
          required int perPage}) async {
    try {
      final result = await apiDataSource.getPayrolls(
        month: month,
        year: year,
        page: page,
        perPage: perPage,
      );
      return Right(PaginateData(
        data: result.data,
        meta: result.meta,
      ));
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, PayrollDetailEntity>> getDetailPayroll(int id) async {
    try {
      final result = await apiDataSource.getDetailPayroll(id);
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, PayrollDetailEntity>> getDetailPayrollTHR(
      int id) async {
    try {
      final result = await apiDataSource.getDetailPayrollTHR(id);
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, PaginateData<List<PayrollEntity>, MetaData>>>
      getPayrollsTHR({required int page, required int perPage}) async {
    try {
      final result = await apiDataSource.getPayrollsTHR(
        page: page,
        perPage: perPage,
      );
      return Right(PaginateData(
        data: result.data,
        meta: result.meta,
      ));
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }
}
