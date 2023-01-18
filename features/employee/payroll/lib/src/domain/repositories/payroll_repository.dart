import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../payroll.dart';

// ignore: one_member_abstracts
abstract class PayrollRepository {
  Future<Either<Failure, PaginateData<List<PayrollEntity>, MetaData>>>
      getPayrolls({
    required int? month,
    required int? year,
    required int page,
    required int perPage,
  });

  Future<Either<Failure, PayrollDetailEntity>> getDetailPayroll(int id);

  Future<Either<Failure, PaginateData<List<PayrollEntity>, MetaData>>>
      getPayrollsTHR({
    required int page,
    required int perPage,
  });

  Future<Either<Failure, PayrollDetailEntity>> getDetailPayrollTHR(int id);
}
