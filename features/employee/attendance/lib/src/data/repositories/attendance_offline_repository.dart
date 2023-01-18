import 'dart:io';

import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:collection/collection.dart';
import 'package:dependencies/dependencies.dart';
import 'package:files/files.dart';
import 'package:settings/settings.dart';

class AttendanceOfflineRepositoryImpl implements AttendanceOfflineRepository {
  final AttendanceLocalDataSource localDataSource;
  final AttendanceApiDataSource apiDataSource;

  AttendanceOfflineRepositoryImpl({
    required this.localDataSource,
    required this.apiDataSource,
  });

  @override
  Future<Either<Failure, bool>> clearSavedAttendances(
      {bool withToday = false}) async {
    try {
      final todayData = await getTodayAttendance();
      final savedData = await getSavedAttendances();

      for (final item in savedData.getOrElse(() => [])) {
        if (withToday || !item.date.isToday()) {
          try {
            if ((item.clockIn?.localImage ?? '').isNotEmpty) {
              File(item.clockIn!.localImage!).deleteSync();
            }
            if ((item.clockOut?.localImage ?? '').isNotEmpty) {
              File(item.clockOut!.localImage!).deleteSync();
            }
          } catch (_) {}
        }
      }

      final result = await localDataSource.clearSavedAttendances();

      if (!withToday) {
        final data = todayData.foldRight(null, (r, previous) => r);

        if (data != null) {
          if (data.clockIn != null) await saveAttendance(data.clockIn!);
          if (data.clockOut != null) await saveAttendance(data.clockOut!);
        }
      }

      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceOfflineDataEntity>>>
      getSavedAttendances() async {
    try {
      final result = await localDataSource.getSavedAttendances();

      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AttendanceOfflineDataEntity>>
      getTodayAttendance() async {
    try {
      final allData = await localDataSource.getSavedAttendances();
      final result = allData.firstWhereOrNull((element) {
        return element.date.isToday();
      });

      if (result == null) {
        return const Left(
            NotFoundCacheFailure(message: 'No attendance found for today'));
      }

      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveAttendance(
      AttendanceOfflineEntity data) async {
    try {
      final currentData = await localDataSource.getSavedAttendances();

      final List<AttendanceOfflineDataEntity> newData = [];

      bool isAlreadyClockToday = false;

      for (final item in currentData) {
        if (item.date.isSameDay(data.date)) {
          isAlreadyClockToday = true;
          newData.add(
            item.copyWith(
              clockIn: data.type == AttendanceClockType.clockIn
                  ? data
                  : item.clockIn,
              clockOut: data.type == AttendanceClockType.clockOut
                  ? data
                  : item.clockOut,
            ),
          );
        } else {
          newData.add(item);
        }
      }

      if (!isAlreadyClockToday) {
        newData.add(
          AttendanceOfflineDataEntity(
            date: data.date,
            clockIn: data.copyWith(
              type: AttendanceClockType.clockIn,
            ),
          ),
        );
      }

      final result = await localDataSource.saveAttendance(newData);

      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> syncAttendance(
      List<AttendanceOfflineEntity> data) async {
    try {
      if (data.isEmpty) return const Right(true);

      final result = await apiDataSource
          .syncAttendances(data.map((e) => e.toJson()).toList());
      return Right(result);
    } on ServerException catch (e, stackTrace) {
      if (e.code != null) {
        GetIt.I<RecordErrorUseCase>()(
          RecordErrorParams(
            exception: e,
            stackTrace: stackTrace,
            errorMessage:
                'Cannot sync attendance becase have error: ${e.message}',
            tags: const ['unhandle-error', 'flutter-error', 'sync-attendance'],
          ),
        );
      }
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, List<NetworkFileEntity>>> uploadAttendanceImages(
      List<File> files) async {
    try {
      final result =
          await apiDataSource.uploadAttendanceImages(files.toFormData());

      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }
}
