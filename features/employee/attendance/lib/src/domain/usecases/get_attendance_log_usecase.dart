import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class GetAttendanceLogUseCase
    implements UseCase<List<AttendanceEntity>, AttendanceLogParams> {
  final AttendanceRepository repository;

  GetAttendanceLogUseCase(this.repository);
  @override
  Future<Either<Failure, List<AttendanceEntity>>> call(
      AttendanceLogParams params) async {
    return await repository.getAttendanceLogs(
      params.month,
      params.year,
      status: params.status,
    );
  }
}

class AttendanceLogParams {
  final int month;
  final int year;
  final AttendanceLogType? status;

  AttendanceLogParams({
    required this.month,
    required this.year,
    this.status,
  });
}
