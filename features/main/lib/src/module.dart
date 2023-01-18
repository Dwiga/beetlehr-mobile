import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../main.dart';

class MainModule implements BaseModule {
  @override
  void inject(GetIt getIt) {}

  @override
  Map<String, Route> routes(RouteSettings settings) {
    // final args = (settings.arguments ?? {}) as Map;
    return {
      '/': CupertinoPageRoute(
          builder: (_) => const MainPage(), settings: settings),
    };
  }
}
