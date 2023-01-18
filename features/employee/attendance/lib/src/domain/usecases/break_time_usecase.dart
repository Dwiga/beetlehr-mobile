import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class BreakTimeUseCase implements UseCase<BreakTimeModel, BreakTimeBodyModel> {
  final AttendanceRepository repository;

  BreakTimeUseCase(this.repository);

  @override
  Future<Either<Failure, BreakTimeModel>> call(
      BreakTimeBodyModel params) async {
    return await repository.breakTime(params);
  }
}
