import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../resign.dart';
import 'presentation/blocs/blocs.dart';

class ResignModule implements BaseModule {
  @override
  void inject(GetIt getIt) {
    // Data
    getIt.registerLazySingleton<ResignApiDataSource>(
        () => ResignApiDataSourceImpl(getIt()));
    getIt.registerLazySingleton<ResignRepository>(
        () => ResignRepositoryImpl(getIt()));

    // Domain
    getIt.registerLazySingleton(() => CreateResignUseCase(getIt()));
    getIt.registerLazySingleton(() => GetResignUseCase(getIt()));
    getIt.registerLazySingleton(() => CancelResignUseCase(getIt()));

    // Presentation
    getIt.registerFactory(() => CreateResignBloc(getIt()));
    getIt.registerFactory(() => ResignBloc(getIt()));
    getIt.registerFactory(() => CancelResignBloc(getIt()));
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    final args = (settings.arguments ?? {}) as Map;
    return {
      '/resign-application': CupertinoPageRoute(
        builder: (_) => const ResignPage(),
        settings: settings,
      ),
      '/resign-application/add': CupertinoPageRoute(
        builder: (_) => const CreateResignPage(),
        settings: settings,
      ),
      '/resign-application/detail': CupertinoPageRoute(
        builder: (_) => DetailResignPage(
          data: args['data'],
        ),
        settings: settings,
      ),
    };
  }
}
