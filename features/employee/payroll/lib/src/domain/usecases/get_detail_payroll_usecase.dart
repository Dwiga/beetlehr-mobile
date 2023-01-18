import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../payroll.dart';

class GetDetailPayrollUseCase implements UseCase<PayrollDetailEntity, int> {
  final PayrollRepository repository;

  GetDetailPayrollUseCase(this.repository);
  @override
  Future<Either<Failure, PayrollDetailEntity>> call(int params) async {
    return await repository.getDetailPayroll(params);
  }
}
