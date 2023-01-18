import 'dart:developer';

import 'package:attendance/attendance.dart';
import 'package:auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_employee/home.dart';
import 'package:leave/leave.dart';
import 'package:main/main.dart';
import 'package:notice/notice.dart';
import 'package:payroll/payroll.dart';
import 'package:profile/profile.dart';
import 'package:resign/resign.dart';
import 'package:settings/settings.dart';

import 'pages/pages.dart';

class AppRoutes {
  ///
  static Route<dynamic> routes(RouteSettings settings) {
    // List all routes module
    final _routeModules = <String, Route>{}
      ..addAll(AttendanceModule().routes(settings))
      ..addAll(AuthModule().routes(settings))
      ..addAll(SettingsModule().routes(settings))
      ..addAll(ProfileModule().routes(settings))
      ..addAll(HomeModule().routes(settings))
      ..addAll(NoticeModule().routes(settings))
      ..addAll(PayrollModule().routes(settings))
      ..addAll(LeaveModule().routes(settings))
      ..addAll(ResignModule().routes(settings))
      ..addAll(MainModule().routes(settings));

    log('Navigate to ${settings.name}', name: 'NAVIGATOR');
    return _routeModules['${Uri.parse(settings.name ?? '').path}'] ??
        CupertinoPageRoute(builder: (_) => NotFoundPage());
  }
}
