import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/cupertino.dart';

import '../auth.dart';

class AuthModule implements BaseModule {
  @override
  void inject(GetIt getIt) {
    //    Data
    getIt.registerLazySingleton<AuthApiDataSource>(
        () => AuthApiDataSourceImpl(getIt()));
    getIt.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(getIt()));
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          apiDataSource: getIt(),
          localDataSource: getIt(),
        ));

    //    Domain
    getIt.registerLazySingleton(() => LoginWithEmailUseCase(getIt()));
    getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt()));
    getIt.registerLazySingleton(() => LogOutUseCase(getIt()));

    //    Presentation
    getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(
          repository: getIt(),
          logOutUseCase: getIt(),
          savePushNotificationUseCase: getIt(),
        ));
    getIt.registerFactory<LoginBloc>(
        () => LoginBloc(loginWithEmailUseCase: getIt()));
    getIt.registerFactory<ResetPassBloc>(
      () => ResetPassBloc(getIt()),
    );

    // External
    getIt.registerLazySingleton(() => FlutterDeviceId());
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    // final args = (settings.arguments ?? {}) as Map;

    return {
      '/login-with-email': CupertinoPageRoute(
        builder: (_) => const LoginWithEmailPage(),
        settings: settings,
      ),
      '/login-with-whatsapp': CupertinoPageRoute(
        builder: (_) => const LoginWithWhatsAppPage(),
        settings: settings,
      ),
      '/forgot-password': CupertinoPageRoute(
        builder: (_) => const ForgotPasswordPage(),
        settings: settings,
      ),
    };
  }
}
