import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class AttendanceClockUseCase
    implements UseCase<AttendanceResponseModel, ClockBodyModel> {
  final AttendanceRepository repository;

  AttendanceClockUseCase(this.repository);
  @override
  Future<Either<Failure, AttendanceResponseModel>> call(
      ClockBodyModel params) async {
    return await repository.clockAttendance(params);
  }
}
