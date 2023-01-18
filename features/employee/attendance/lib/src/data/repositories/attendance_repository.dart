import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../attendance.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceApiDataSource apiDataSource;
  final AttendanceLocalDataSource localDataSource;

  AttendanceRepositoryImpl({
    required this.apiDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AttendanceOverviewEntity>> getAttendanceOverview(
      DateTime date) async {
    try {
      final result = await apiDataSource
          .getAttendanceOverview(DateFormat('y-MM-dd').format(date).toString());
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, AttendanceImageModel>> uploadAttendanceImage(
      UploadAttendanceImageBodyModel body) async {
    try {
      final result =
          await apiDataSource.uploadAttendanceImage(await body.toJson());
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getAttendanceLogs(
      int month, int year,
      {AttendanceLogType? status}) async {
    try {
      final result = await apiDataSource.getAttendanceLogs(
        month,
        year,
        status: status?.convertToString(),
      );
      return Right(result.data.map((e) => e).toList());
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, OfficePlacementEntity>> checkPlacementOffice(
      Map<String, dynamic> body) async {
    try {
      final result = await apiDataSource.checkPlacementOffice(body);
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, AttendanceDetailDataEntity>> getAttendanceDetail(
      DateTime date) async {
    try {
      final result = await apiDataSource
          .getAttendanceDetail(DateFormat('y-MM-dd').format(date).toString());
      return Right(AttendanceDetailDataEntity(
        attendances: result.data.map((e) => e).toList(),
        totalHours: result.totalHours,
      ));
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, ClockAcceptModel>> checkAcceptClock(
      ClockBodyModel body) async {
    try {
      final result = await apiDataSource.checkAcceptClock(body.toJsonNoFiles());
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, AttendanceResponseModel>> clockAttendance(
      ClockBodyModel body) async {
    try {
      final result = await apiDataSource.clockAttendance(body.toJson());

      if (body.type == AttendanceType.normal) {
        await localDataSource.clearSavedAttendances();
      }
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ScheduleEntity>>> getSchedule(
      DateTime date) async {
    try {
      final result = await apiDataSource
          .getSchedule(DateFormat('y-MM-dd').format(date).toString());
      return Right(result.data.map((e) => e).toList());
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, bool>> checkAcceptClockAttendance(
      CheckAcceptClockBodyModel body) async {
    try {
      final result =
          await apiDataSource.checkAcceptClockAttendance(body.toJson());
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, List<ScheduleEntity>>> getScheduleLog(
      DateTime startDate, DateTime endDate) async {
    try {
      final result = await apiDataSource.getScheduleLog(
          DateFormat('y-MM-dd').format(startDate),
          DateFormat('y-MM-dd').format(endDate));
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, ClockButtonModel>> getClockButtonType() async {
    try {
      final result = await apiDataSource.getClockButtonType();
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, bool>> cancelAtetndance() async {
    try {
      final result = await apiDataSource.cancelAttendance();
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, BreakTimeModel>> breakTime(
      BreakTimeBodyModel body) async {
    try {
      final result = await apiDataSource.breakTime(body.toJson());
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, bool>> checkBreakTimeSetting() async {
    try {
      final result = await apiDataSource.checkBreakTimeSetting();
      return Right(result);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }
}
