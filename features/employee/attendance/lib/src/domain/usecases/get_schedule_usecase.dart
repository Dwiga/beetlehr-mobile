import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class GetScheduleUseCase
    implements UseCase<List<ScheduleEntity>, ScheduleParams> {
  final AttendanceRepository repository;

  GetScheduleUseCase(this.repository);

  @override
  Future<Either<Failure, List<ScheduleEntity>>> call(
      ScheduleParams params) async {
    return await repository.getSchedule(params.date);
  }
}

class ScheduleParams {
  final DateTime date;

  ScheduleParams(this.date);
}
