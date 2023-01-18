import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class GetAttendanceOverviewUseCase
    implements UseCase<AttendanceOverviewEntity, AttendanceOverviewParams> {
  final AttendanceRepository repository;

  GetAttendanceOverviewUseCase(this.repository);
  @override
  Future<Either<Failure, AttendanceOverviewEntity>> call(
      AttendanceOverviewParams params) async {
    return await repository.getAttendanceOverview(params.date);
  }
}

class AttendanceOverviewParams {
  final DateTime date;
  AttendanceOverviewParams({
    required this.date,
  });
}
