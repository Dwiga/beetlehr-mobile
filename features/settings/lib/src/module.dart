import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/cupertino.dart';

import '../settings.dart';

class SettingsModule implements BaseModule {
  @override
  void inject(GetIt getIt) async {
    //    -------------
    // Data Layer

    // Data Source
    getIt.registerLazySingleton<SettingLocalDataSource>(
      () => SettingLocalDataSourceImpl(
        cacheManager: getIt(),
      ),
    );
    getIt.registerLazySingleton<ServerLocalDataSource>(
      () => ServerLocalDataSourceImpl(
        cacheManager: getIt(),
      ),
    );

    getIt.registerLazySingleton<SettingApiDataSource>(
      () => SettingApiDataSourceImpl(getIt()),
    );

    getIt.registerLazySingleton<ServerApiDataSource>(
      () => ServerApiDataSourceImpl(getIt()),
    );

    // Repository
    getIt.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(
        localDataSource: getIt(),
      ),
    );
    getIt.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl(
        getIt(),
      ),
    );
    getIt.registerLazySingleton<SettingRepository>(
      () => SettingRepositoryImpl(
        localDataSource: getIt(),
        apiDataSource: getIt(),
      ),
    );
    getIt.registerLazySingleton<ServerRepository>(
      () => ServerRepositoryImpl(
        apiDataSource: getIt(),
        localDataSource: getIt(),
      ),
    );

    //    -------------
    // Domain Layer

    //UseCase
    getIt.registerLazySingleton(() => GetLanguageUseCase(getIt()));
    getIt.registerLazySingleton(() => SetLanguageUseCase(getIt()));
    getIt.registerLazySingleton(() => SaveTokenUseCase(getIt()));
    getIt.registerLazySingleton(() => GetAppUrlUseCase(getIt()));
    getIt.registerLazySingleton(() => GetBaseUrlUseCase(getIt()));
    getIt.registerLazySingleton(() => SetBaseUrlUseCase(getIt()));
    getIt.registerLazySingleton(() => DeleteBaseUrlUseCase(getIt()));
    getIt.registerLazySingleton(
        () => RecordErrorUseCase(FirebaseCrashlytics.instance));
    getIt.registerLazySingleton(() => CheckServerUseCase(getIt()));

    // Service
    getIt.registerLazySingleton(
      () => PushNotificationService(useCase: getIt())..initialize(),
    );
    Future.delayed(const Duration(seconds: 5)).then(
      (_) => getIt<PushNotificationService>().initialize(),
    );
    getIt.registerLazySingleton(() => RemoteConfigService());

    //    -------------
    // Presentation Layer
    getIt.registerFactory(() => ThemeBloc(repository: getIt()));
    getIt.registerFactory(() => LanguageBloc(
          getLanguageUseCase: getIt(),
          setLanguageUseCase: getIt(),
        ));
    getIt.registerFactory(() => AccessBloc());
    getIt.registerFactory(() => UrlSettingBloc(getIt()));
    getIt.registerFactory(
        () => ServerBloc(repository: getIt(), useCase: getIt()));
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    // final args = (settings.arguments ?? {}) as Map;

    return {
      '/setting-language': CupertinoPageRoute(
        builder: (_) => const SettingLanguagePage(),
        settings: settings,
      ),
      '/setting-url': CupertinoPageRoute(
        builder: (_) => const SettingUrlPage(),
        settings: settings,
      ),
    };
  }
}
