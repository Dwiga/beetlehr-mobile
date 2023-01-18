import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetSavedAttendancesUseCase
    implements UseCase<List<AttendanceOfflineDataEntity>, NoParams> {
  final AttendanceOfflineRepository repository;

  const GetSavedAttendancesUseCase(this.repository);

  @override
  Future<Either<Failure, List<AttendanceOfflineDataEntity>>> call(
      NoParams params) {
    return repository.getSavedAttendances();
  }
}
