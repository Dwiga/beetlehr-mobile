import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../../../leave.dart';

class CancelLeaveUseCase implements UseCase<bool, int> {
  final LeaveRepository repository;

  CancelLeaveUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await repository.cancelLeave(params);
  }
}
