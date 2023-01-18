import 'package:flutter/material.dart';

import '../../core.dart';

/// Handle snackbars in navigator
class SnackbarNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    IndicatorsUtils.hideCurrentSnackBar();
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    IndicatorsUtils.hideCurrentSnackBar();
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    IndicatorsUtils.hideCurrentSnackBar();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    IndicatorsUtils.hideCurrentSnackBar();
    super.didPush(route, previousRoute);
  }
}
