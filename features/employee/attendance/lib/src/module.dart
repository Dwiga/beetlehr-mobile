import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/cupertino.dart';

import '../attendance.dart';
import 'presentation/pages/view_location_page.dart';

class AttendanceModule implements BaseModule {
  @override
  void inject(GetIt getIt) {
    // Data
    getIt.registerLazySingleton<AttendanceApiDataSource>(
        () => AttendanceApiDataSourceImpl(getIt()));
    getIt.registerLazySingleton<AttendanceLocalDataSource>(
        () => AttendanceLocalDataSourceImpl(getIt()));
    getIt.registerLazySingleton<AttendanceRepository>(
        () => AttendanceRepositoryImpl(
              apiDataSource: getIt(),
              localDataSource: getIt(),
            ));
    getIt.registerLazySingleton<AttendanceOfflineRepository>(
      () => AttendanceOfflineRepositoryImpl(
        localDataSource: getIt(),
        apiDataSource: getIt(),
      ),
    );

    //    Domain
    getIt.registerLazySingleton<GetAttendanceOverviewUseCase>(
      () => GetAttendanceOverviewUseCase(getIt()),
    );
    getIt.registerLazySingleton(() => UploadAttendanceImageUseCase(getIt()));
    getIt.registerLazySingleton(() => GetAttendanceLogUseCase(getIt()));
    getIt.registerLazySingleton(
      () => GetCheckPlacementOfficeUseCase(getIt()),
    );
    getIt.registerLazySingleton(() => GetAttendanceDetailUseCase(getIt()));
    getIt.registerLazySingleton(() => CheckAcceptClockUseCase(getIt()));
    getIt.registerLazySingleton(() => AttendanceClockUseCase(getIt()));
    getIt.registerLazySingleton(() => GetScheduleUseCase(getIt()));
    getIt.registerLazySingleton(
      () => GetCheckActiveAttendanceUseCase(getIt()),
    );
    getIt.registerLazySingleton(() => GetScheduleLogUseCase(getIt()));
    getIt.registerLazySingleton(() => GetClockButtonTypeUseCase(getIt()));
    getIt.registerLazySingleton(() => ClearSavedAttendancesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetSavedAttendancesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetTodaySavedAttendanceUseCase(getIt()));
    getIt.registerLazySingleton(() => SaveAttendanceUseCase(getIt()));
    getIt.registerLazySingleton(() => SyncAttendancesUseCase(getIt()));
    getIt.registerLazySingleton(() => CancelAttendanceUseCase(getIt()));
    getIt.registerLazySingleton(() => BreakTimeUseCase(getIt()));
    getIt.registerLazySingleton(() => GetCheckBreakTimeSettingUseCase(getIt()));

    //    Presentation
    getIt.registerFactory(() => AttendanceOverviewBloc(getIt()));
    getIt.registerFactory(() => UploadPhotoBloc(getIt()));
    getIt.registerFactory(() => AttendanceLogBloc(getIt()));
    getIt.registerFactory(() => CheckPlacementBloc(getIt()));
    getIt.registerFactory(() => AttendanceDetailBloc(getIt()));
    getIt.registerFactory(() => AcceptClockBloc(getIt()));
    getIt.registerFactory(() => AttendanceBloc(getIt()));
    getIt.registerFactory(() => ScheduleBloc(getIt()));
    getIt.registerFactory(() => CheckAttendanceBloc(getIt()));
    getIt.registerFactory(() => ScheduleLogBloc(getIt()));
    getIt.registerFactory(() => ClockButtonTypeBloc(getIt()));
    getIt.registerFactory(() => BreakTimeBloc(getIt()));
    getIt.registerFactory(() => CheckBreakTimeSettingBloc(getIt()));
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    final args = (settings.arguments ?? {}) as Map;

    return {
      '/attendance/clock-in/take-photo': CupertinoPageRoute(
          builder: (_) => TakePhotoClockInPage(
                workingFrom: args['working_from'],
              ),
          settings: settings),
      '/attendance/clock-out/take-photo': CupertinoPageRoute(
          builder: (_) => TakePhotoClockOutPage(
                workingFrom: args['working_from'],
              ),
          settings: settings),
      '/attendance/log': CupertinoPageRoute(
          builder: (_) => AttendanceLogPage(
                type: args['type'] ?? AttendanceLogContentType.schedule,
                logFilter: args['log_filter'],
              ),
          settings: settings),
      '/attendance/clock-in/check-placement': CupertinoPageRoute(
          builder: (_) => CheckPlacementClockInPage(
                imageId: args['imageId'],
                workingFrom: args['working_from'],
              ),
          settings: settings),
      '/attendance/clock-out/check-placement': CupertinoPageRoute(
          builder: (_) => CheckPlacementClockOutPage(
                imageId: args['imageId'],
                workingFrom: args['working_from'],
              ),
          settings: settings),
      '/attendance/detail': CupertinoPageRoute(
          builder: (_) => DetailAttendancePage(
                date: args['date'],
                onBack: args['onBack'],
              ),
          settings: settings),
      '/attendance/clock-in': CupertinoPageRoute(
          builder: (_) => ClockInPage(
                data: args['data'],
                clockBody: args['clockBody'],
              ),
          settings: settings),
      '/attendance/clock-out': CupertinoPageRoute(
          builder: (_) => ClockOutPage(
                data: args['data'],
                clockBody: args['clockBody'],
              ),
          settings: settings),
      '/attendance/view-location': CupertinoPageRoute(
        builder: (_) => ViewLocationPage(
          latitude: args['latitude'],
          longitude: args['longitude'],
        ),
      ),
      '/attendance/offline/take-photo': CupertinoPageRoute(
        builder: (_) => TakePhotoOfflinePage(
          clockOut: args['clock_out'] ?? false,
          workingFrom: args['working_from'],
        ),
      ),
      '/attendance/offline/clock-in': CupertinoPageRoute(
        builder: (_) => ClockInOfflinePage(
          photoPath: args['photo_path'],
          workingFrom: args['working_from'],
        ),
      ),
      '/attendance/offline/clock-out': CupertinoPageRoute(
        builder: (_) => ClockOutOfflinePage(
          photoPath: args['photo_path'],
          workingFrom: args['working_from'],
        ),
      ),
      '/attendance/break-time': CupertinoPageRoute(
          builder: (_) => BreakTimePage(
                startBreakTime: args['start_time'],
              ),
          settings: settings),
    };
  }
}
