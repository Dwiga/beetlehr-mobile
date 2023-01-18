import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class CancelAttendanceUseCase implements UseCase<bool, NoParams> {
  final AttendanceRepository repository;

  const CancelAttendanceUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.cancelAtetndance();
  }
}
