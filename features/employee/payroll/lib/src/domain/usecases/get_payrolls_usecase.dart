import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../payroll.dart';

class GetPayrollsUseCase
    implements
        UseCase<PaginateData<List<PayrollEntity>, MetaData>, PayrollParams> {
  final PayrollRepository repository;

  GetPayrollsUseCase(this.repository);

  @override
  Future<Either<Failure, PaginateData<List<PayrollEntity>, MetaData>>> call(
      PayrollParams params) async {
    return await repository.getPayrolls(
      month: params.month,
      year: params.year,
      page: params.page,
      perPage: params.perPage,
    );
  }
}

class PayrollParams {
  final int? year;
  final int? month;
  final int page;
  final int perPage;

  PayrollParams({
    required this.year,
    required this.month,
    required this.page,
    required this.perPage,
  });
}
