import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:attendance/attendance.dart';

class GetCheckBreakTimeSettingUseCase implements UseCase<bool, NoParams> {
  final AttendanceRepository repository;

  GetCheckBreakTimeSettingUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkBreakTimeSetting();
  }
}
