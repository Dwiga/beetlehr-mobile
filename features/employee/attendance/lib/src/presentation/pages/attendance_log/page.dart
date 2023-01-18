import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../attendance.dart';
import 'logs.dart';
import 'schedule.dart';

enum AttendanceLogContentType { schedule, logs }

class AttendanceLogPage extends StatefulWidget {
  const AttendanceLogPage({Key? key, this.logFilter, required this.type})
      : super(key: key);

  final AttendanceLogType? logFilter;
  final AttendanceLogContentType type;

  @override
  _AttendanceLogPageState createState() => _AttendanceLogPageState();
}

class _AttendanceLogPageState extends State<AttendanceLogPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<AttendanceLogBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<ScheduleLogBloc>(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        initialIndex: widget.type.index,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).attendance),
            bottom: TabBar(
              indicatorColor: StaticColors.red,
              tabs: [
                Tab(text: S.of(context).schedule),
                Tab(text: S.of(context).logs),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const ScheduleLogsPage(),
              LogsPage(
                logStatus: widget.logFilter,
              ),
            ],
            physics: const BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
