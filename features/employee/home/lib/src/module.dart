import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../home.dart';

class HomeModule implements BaseModule {
  @override
  void inject(GetIt getIt) {
    getIt.registerFactory(() => BottomNavBloc());
    getIt.registerFactory(() => ClockOfflineButtonTypeBloc(getIt()));
    getIt.registerFactory(() => PendingAttendancesBloc(getIt()));
    getIt.registerFactory(() => ConnectionModeBloc());
    getIt.registerFactory(() => CancelAttendanceBloc(getIt()));
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    return {};
  }
}
