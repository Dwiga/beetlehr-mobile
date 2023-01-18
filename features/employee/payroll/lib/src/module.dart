import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../payroll.dart';

class PayrollModule implements BaseModule {
  @override
  void inject(GetIt getIt) {
    // Data
    getIt.registerLazySingleton<PayrollApiDataSource>(
      () => PayrollApiDataSourceImpl(
        getIt(),
      ),
    );
    getIt.registerLazySingleton<PayrollRepository>(
      () => PayrollRepositoryImpl(getIt()),
    );

    // Domain
    getIt.registerLazySingleton(() => GetPayrollsUseCase(getIt()));
    getIt.registerLazySingleton(() => GetDetailPayrollUseCase(getIt()));
    getIt.registerLazySingleton(() => GetPayrollsTHRUseCase(getIt()));
    getIt.registerLazySingleton(() => GetDetailPayrollTHRUseCase(getIt()));

    // Presentation
    getIt.registerFactory(() => PayrollBloc(getIt()));
    getIt.registerFactory(() => PayrollDetailBloc(getIt()));
    getIt.registerFactory(() => PayrollTHRBloc(getIt()));
    getIt.registerFactory(() => PayrollTHRDetailBloc(getIt()));
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    final args = (settings.arguments ?? {}) as Map;

    return {
      '/payroll': CupertinoPageRoute(
        builder: (_) => const PayrollPage(),
        settings: settings,
      ),
      '/payroll-detail': CupertinoPageRoute(
        builder: (_) => PayrollDetailPage(
          data: args['data'],
        ),
        settings: settings,
      ),
    };
  }
}
