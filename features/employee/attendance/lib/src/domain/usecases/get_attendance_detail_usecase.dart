import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class GetAttendanceDetailUseCase
    implements UseCase<AttendanceDetailDataEntity, AttendanceDetailParams> {
  final AttendanceRepository repository;

  GetAttendanceDetailUseCase(this.repository);
  @override
  Future<Either<Failure, AttendanceDetailDataEntity>> call(
      AttendanceDetailParams params) async {
    return await repository.getAttendanceDetail(params.date);
  }
}

class AttendanceDetailParams {
  final DateTime date;

  AttendanceDetailParams(this.date);
}
