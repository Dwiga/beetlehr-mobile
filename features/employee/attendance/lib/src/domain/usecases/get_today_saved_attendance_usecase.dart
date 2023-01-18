import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTodaySavedAttendanceUseCase
    implements UseCase<AttendanceOfflineDataEntity, NoParams> {
  final AttendanceOfflineRepository repository;

  const GetTodaySavedAttendanceUseCase(this.repository);

  @override
  Future<Either<Failure, AttendanceOfflineDataEntity>> call(NoParams params) {
    return repository.getTodayAttendance();
  }
}
