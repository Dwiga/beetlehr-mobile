import 'dart:io';

import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:settings/settings.dart';

class SyncAttendancesUseCase implements UseCase<bool, NoParams> {
  final AttendanceOfflineRepository repository;

  const SyncAttendancesUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final rawData = await repository.getSavedAttendances();

    final savedData = rawData.getOrElse(() => []);
    if (savedData.isEmpty) return const Right(true);

    final List<AttendanceOfflineEntity> tempAttendance =
        <AttendanceOfflineEntity>[];

    for (final item in savedData) {
      if (item.clockIn != null && item.clockIn?.isSynced != true) {
        tempAttendance.add(item.clockIn!);
      }

      if (item.clockOut != null && item.clockOut?.isSynced != true) {
        tempAttendance.add(item.clockOut!);
      }
    }

    if (tempAttendance.isEmpty) {
      repository.clearSavedAttendances(withToday: false);
      return const Right(true);
    }

    final rawPhotos = await repository.uploadAttendanceImages(
        tempAttendance.map((e) => File(e.localImage!)).toList());

    if (rawPhotos.isLeft()) {
      rawPhotos.fold((failure) {
        if (failure.code != null || failure.code != 401) {
          GetIt.I<RecordErrorUseCase>()(
            RecordErrorParams(
              exception: DefaultApiException(
                  message: failure.message, code: failure.code),
              stackTrace: StackTrace.current,
              errorMessage: 'Failed to upload photo sync saved attendance',
              level: failure.code != null && failure.code! >= 400
                  ? SentryLevel.fatal
                  : SentryLevel.info,
              tags: const ['sync_saved_attendance'],
            ),
          );
        }
      }, (_) {});

      return Left(
        rawPhotos.foldLeft(
            const DefaultServerFailure(message: ''), (previous, r) => previous),
      );
    }

    final photos = rawPhotos.getOrElse(() => []);

    final List<AttendanceOfflineEntity> result = [];

    assert(photos.length == tempAttendance.length);

    for (var i = 0; i < photos.length; i++) {
      result.add(
        tempAttendance[i].copyWith(
          imageId: photos[i].id,
        ),
      );
    }

    return repository.syncAttendance(result);
  }
}
