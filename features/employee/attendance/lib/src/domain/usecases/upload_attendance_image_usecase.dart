import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class UploadAttendanceImageUseCase
    implements UseCase<AttendanceImageModel, UploadAttendanceImageBodyModel> {
  final AttendanceRepository repository;

  UploadAttendanceImageUseCase(this.repository);
  @override
  Future<Either<Failure, AttendanceImageModel>> call(
      UploadAttendanceImageBodyModel params) async {
    return await repository.uploadAttendanceImage(params);
  }
}
