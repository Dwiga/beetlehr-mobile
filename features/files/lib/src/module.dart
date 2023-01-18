import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../files.dart';

class FilesModule implements BaseModule {
  @override
  void inject(GetIt getIt) async {
    // Data
    getIt.registerLazySingleton<FilesApiDataSource>(
        () => FilesApiDataSourceImpl(getIt()));
    getIt.registerLazySingleton<FilesRepository>(
        () => FilesRepositoryImpl(getIt()));
    getIt.registerLazySingleton<FilesDeviceDataSource>(
        () => FilesDeviceDataSourceImpl());

    // Domain
    getIt.registerLazySingleton(() => DownloadFileUseCase(getIt()));
    getIt.registerLazySingleton(() => SaveFileDownloadFolderUseCase(getIt()));
    getIt.registerLazySingleton(() => UploadFilesUseCase(getIt()));
    getIt.registerLazySingleton(() => UploadAnyFilesUseCase(getIt()));

    // Presentation
    getIt.registerFactory(() => UploadFilesBloc(getIt()));
    getIt.registerFactory(() => UploadAnyFilesBloc(getIt()));
    getIt.registerFactory(() => DownloadFileBloc(getIt()));

    // External
    WidgetsFlutterBinding.ensureInitialized();
    DownloadFileUseCase.initialize();
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    return {};
  }
}
