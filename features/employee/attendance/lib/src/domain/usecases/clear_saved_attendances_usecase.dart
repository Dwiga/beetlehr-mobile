import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

/// Bool params for delete with today's date
class ClearSavedAttendancesUseCase implements UseCase<bool, bool> {
  final AttendanceOfflineRepository repository;

  const ClearSavedAttendancesUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(bool params) {
    return repository.clearSavedAttendances(withToday: params);
  }
}
