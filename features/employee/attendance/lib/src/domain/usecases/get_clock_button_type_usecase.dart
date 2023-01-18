import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetClockButtonTypeUseCase implements UseCase<ClockButtonModel, NoParams> {
  final AttendanceRepository attendanceRepository;

  const GetClockButtonTypeUseCase(this.attendanceRepository);

  @override
  Future<Either<Failure, ClockButtonModel>> call(NoParams params) {
    return attendanceRepository.getClockButtonType();
  }
}
