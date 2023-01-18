import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class GetScheduleLogUseCase
    implements UseCase<List<ScheduleEntity>, ScheduleLogParams> {
  final AttendanceRepository repository;

  GetScheduleLogUseCase(this.repository);

  @override
  Future<Either<Failure, List<ScheduleEntity>>> call(
      ScheduleLogParams params) async {
    return await repository.getScheduleLog(params.startDate, params.endDate);
  }
}

class ScheduleLogParams {
  final DateTime startDate;
  final DateTime endDate;

  ScheduleLogParams({required this.startDate, required this.endDate});
}
