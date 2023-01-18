import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../leave.dart';

class GetDetailLeaveUseCase implements UseCase<LeaveDetailEntity, int> {
  final LeaveRepository repository;

  GetDetailLeaveUseCase(this.repository);
  @override
  Future<Either<Failure, LeaveDetailEntity>> call(int params) async {
    return await repository.getDetailLeave(params);
  }
}
