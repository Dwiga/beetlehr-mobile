import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../leave.dart';
import 'presentation/blocs/blocs.dart';

class LeaveModule implements BaseModule {
  @override
  void inject(GetIt getIt) {
    // Data
    getIt.registerLazySingleton<LeaveApiDataSource>(
        () => LeaveApiDataSourceImpl(getIt()));
    getIt.registerLazySingleton<LeaveRepository>(
        () => LeaveRepositoryImpl(apiDataSource: getIt()));

    // Domain
    getIt.registerLazySingleton(() => GetLeavesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetDetailLeaveUseCase(getIt()));
    getIt.registerLazySingleton(() => GetLeaveTypeUseCase(getIt()));
    getIt.registerLazySingleton(() => CreateLeaveUseCase(getIt()));
    getIt.registerLazySingleton(() => CancelLeaveUseCase(getIt()));

    // Presentation
    getIt.registerFactory(() => LeaveCompleteBloc(getIt()));
    getIt.registerFactory(() => LeaveInProcessBloc(getIt()));
    getIt.registerFactory(() => LeaveDetailBloc(getIt()));
    getIt.registerFactory(() => LeaveTypeBloc(getIt()));
    getIt.registerFactory(() => CreateLeaveBloc(getIt()));
    getIt.registerFactory(() => LeaveCancelBloc(getIt()));
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    final args = (settings.arguments ?? {}) as Map;
    return {
      '/leave-application': CupertinoPageRoute(
        builder: (_) => const LeaveApplicationPage(),
        settings: settings,
      ),
      '/leave-application/detail': CupertinoPageRoute(
        builder: (_) => LeaveApplicationDetailPage(
          id: args['id'],
        ),
        settings: settings,
      ),
      '/leave-application/add': CupertinoPageRoute(
        builder: (_) => CreateLeaveApplicationPage(
          maxRangeDays: args['max_range_days'],
        ),
        settings: settings,
      ),
    };
  }
}
