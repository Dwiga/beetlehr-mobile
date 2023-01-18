import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SaveAttendanceUseCase implements UseCase<bool, AttendanceOfflineEntity> {
  final AttendanceOfflineRepository repository;

  const SaveAttendanceUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AttendanceOfflineEntity params) {
    return repository.saveAttendance(params);
  }
}
