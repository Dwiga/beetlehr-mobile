import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class CheckAcceptClockUseCase
    implements UseCase<ClockAcceptModel, ClockBodyModel> {
  final AttendanceRepository repository;

  CheckAcceptClockUseCase(this.repository);
  @override
  Future<Either<Failure, ClockAcceptModel>> call(ClockBodyModel params) async {
    return await repository.checkAcceptClock(params);
  }
}
