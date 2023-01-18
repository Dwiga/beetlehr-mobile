import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../attendance.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, AttendanceOverviewEntity>> getAttendanceOverview(
      DateTime date);

  Future<Either<Failure, AttendanceImageModel>> uploadAttendanceImage(
      UploadAttendanceImageBodyModel body);

  Future<Either<Failure, List<AttendanceEntity>>> getAttendanceLogs(
      int month, int year,
      {AttendanceLogType? status});

  Future<Either<Failure, OfficePlacementEntity>> checkPlacementOffice(
      Map<String, dynamic> body);

  Future<Either<Failure, AttendanceDetailDataEntity>> getAttendanceDetail(
      DateTime date);

  Future<Either<Failure, ClockAcceptModel>> checkAcceptClock(
      ClockBodyModel body);

  Future<Either<Failure, AttendanceResponseModel>> clockAttendance(
      ClockBodyModel body);

  Future<Either<Failure, List<ScheduleEntity>>> getSchedule(DateTime date);

  Future<Either<Failure, bool>> checkAcceptClockAttendance(
      CheckAcceptClockBodyModel body);

  Future<Either<Failure, List<ScheduleEntity>>> getScheduleLog(
      DateTime startDate, DateTime endDate);

  Future<Either<Failure, ClockButtonModel>> getClockButtonType();

  Future<Either<Failure, bool>> cancelAtetndance();

  Future<Either<Failure, BreakTimeModel>> breakTime(BreakTimeBodyModel body);

  Future<Either<Failure, bool>> checkBreakTimeSetting();
}
