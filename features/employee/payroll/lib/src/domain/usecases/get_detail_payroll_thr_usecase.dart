import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../payroll.dart';

class GetDetailPayrollTHRUseCase implements UseCase<PayrollDetailEntity, int> {
  final PayrollRepository repository;

  GetDetailPayrollTHRUseCase(this.repository);
  @override
  Future<Either<Failure, PayrollDetailEntity>> call(int params) async {
    return await repository.getDetailPayrollTHR(params);
  }
}
