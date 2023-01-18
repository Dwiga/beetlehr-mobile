import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../../../leave.dart';

class CreateLeaveUseCase implements UseCase<bool, LeaveBodyModel> {
  final LeaveRepository repository;

  CreateLeaveUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(LeaveBodyModel params) async {
    return await repository.createLeave(params);
  }
}
