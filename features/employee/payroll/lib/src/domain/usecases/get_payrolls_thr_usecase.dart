import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../payroll.dart';

class GetPayrollsTHRUseCase
    implements
        UseCase<PaginateData<List<PayrollEntity>, MetaData>, PaginateParams> {
  final PayrollRepository repository;

  GetPayrollsTHRUseCase(this.repository);

  @override
  Future<Either<Failure, PaginateData<List<PayrollEntity>, MetaData>>> call(
      PaginateParams params) async {
    return await repository.getPayrollsTHR(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
