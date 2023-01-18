import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../notice.dart';

class NoticeModule implements BaseModule {
  @override
  void inject(GetIt getIt) {
    // Data
    getIt.registerLazySingleton<NoticeApiDataSource>(
        () => NoticeApiDataSourceImpl(getIt()));
    getIt.registerLazySingleton<NoticeRepository>(
        () => NoticeRepositoryImpl(apiDataSource: getIt()));

    // Domain
    getIt.registerLazySingleton(() => GetNoticeBoardUseCase(getIt()));
    getIt.registerLazySingleton(() => GetApprovalRequestUseCase(getIt()));
    getIt.registerLazySingleton(() => GetApprovalRequestDetailUseCase(getIt()));
    getIt.registerLazySingleton(() => ApproveRequestUseCase(getIt()));
    getIt.registerLazySingleton(() => RejectRequestUseCase(getIt()));
    getIt.registerLazySingleton(() => GetEmployeeNameFilterUseCase(getIt()));

    // Presentation
    getIt.registerFactory(() => NoticeBoardBloc(
          getNoticeBoardUseCase: getIt(),
        ));

    getIt.registerFactory<AllNoticeBoardBloc>(() => AllNoticeBoardBloc(
          getNoticeBoardUseCase: getIt(),
        ));

    getIt
        .registerFactory<AllAppprovalRequestBloc>(() => AllAppprovalRequestBloc(
              getApprovalRequestUseCase: getIt(),
            ));

    getIt.registerFactory<ApprovalRequestDetailBloc>(
        () => ApprovalRequestDetailBloc(
              getIt(),
            ));

    getIt.registerFactory<ApproveRequestBloc>(() => ApproveRequestBloc(
          getIt(),
        ));

    getIt.registerFactory<RejectRequestBloc>(() => RejectRequestBloc(
          getIt(),
        ));

    getIt.registerFactory<EmployeeNameFilterBloc>(() => EmployeeNameFilterBloc(
          getEmployeeFilterUseCase: getIt(),
        ));
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    final args = (settings.arguments ?? {}) as Map;
    return {
      '/list-need-approval': CupertinoPageRoute(
        builder: (_) => const ListNeedApprovalPage(),
        settings: settings,
      ),
      '/all-notice-board': CupertinoPageRoute(
        builder: (_) => const AllNoticeBoardPage(),
        settings: settings,
      ),
      '/detail-notice': CupertinoPageRoute(
        builder: (_) => DetailNoticePage(
          notice: args['notice'],
        ),
        settings: settings,
      ),
      '/detail-approval-request': CupertinoPageRoute(
        builder: (_) =>
            ApprovalRequestDetailPage(id: args['id'], type: args['type']),
        settings: settings,
      ),
    };
  }
}
