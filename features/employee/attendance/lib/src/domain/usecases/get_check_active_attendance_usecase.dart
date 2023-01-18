import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class GetCheckActiveAttendanceUseCase
    implements UseCase<bool, CheckAcceptClockBodyModel> {
  final AttendanceRepository repository;

  GetCheckActiveAttendanceUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CheckAcceptClockBodyModel params) async {
    return await repository.checkAcceptClockAttendance(params);
  }
}
