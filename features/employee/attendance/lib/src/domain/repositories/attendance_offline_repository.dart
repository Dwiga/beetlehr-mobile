import 'dart:io';

import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:files/files.dart';

abstract class AttendanceOfflineRepository {
  Future<Either<Failure, AttendanceOfflineDataEntity>> getTodayAttendance();

  Future<Either<Failure, List<AttendanceOfflineDataEntity>>>
      getSavedAttendances();

  Future<Either<Failure, bool>> saveAttendance(AttendanceOfflineEntity data);

  Future<Either<Failure, bool>> syncAttendance(
      List<AttendanceOfflineEntity> data);

  Future<Either<Failure, bool>> clearSavedAttendances({bool withToday = false});

  Future<Either<Failure, List<NetworkFileEntity>>> uploadAttendanceImages(
      List<File> files);
}
