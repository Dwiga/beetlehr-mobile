import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../profile.dart';

class ProfileModule implements BaseModule {
  @override
  void inject(GetIt getIt) {
    // Data
    getIt.registerLazySingleton<ProfileApiDataSource>(
        () => ProfileApiDataSourceImpl(getIt()));
    getIt.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(getIt()));

    // Domain
    getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));
    getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));

    // Presentation
    getIt.registerFactory(() => ProfileBloc(getIt()));
    getIt.registerFactory(() => ManipulateProfileBloc(getIt()));
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    final args = (settings.arguments ?? {}) as Map;

    return {
      '/profile/view': CupertinoPageRoute(
        builder: (_) => ViewProfilePage(
          profile: args['profile'],
        ),
        settings: settings,
      ),
      '/profile/edit': CupertinoPageRoute(
        builder: (_) => EditProfilePage(
          profile: args['profile'],
        ),
        settings: settings,
      ),
    };
  }
}
