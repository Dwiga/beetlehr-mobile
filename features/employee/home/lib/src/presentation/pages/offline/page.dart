import 'dart:async';

import 'package:attendance/attendance.dart';
import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:home_employee/home.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../connection_status_section.dart';
import 'sections/sections.dart';

class HomeOfflinePage extends StatefulWidget {
  const HomeOfflinePage({Key? key}) : super(key: key);

  @override
  _HomeOfflinePageState createState() => _HomeOfflinePageState();
}

class _HomeOfflinePageState extends State<HomeOfflinePage> {
  Timer? _timer;

  final _buttonClockTypeBloc = GetIt.I<ClockOfflineButtonTypeBloc>();
  final _pendingAttendances = GetIt.I<PendingAttendancesBloc>();

  @override
  void initState() {
    _fetchData();
    _initRefreshContentPeriodict();
    super.initState();
  }

  void _initRefreshContentPeriodict() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _fetchData();
    });
  }

  void _fetchData() {
    _buttonClockTypeBloc.add(const ClockOfflineButtonTypeFetched());
    _pendingAttendances.add(const PendingAttendancesFetched());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _buttonClockTypeBloc,
        ),
        BlocProvider(
          create: (context) => _pendingAttendances,
        ),
      ],
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            _fetchData();
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              ConnectionStatusSection(
                ignoreOffline: true,
                onSwitchToOnline: () {
                  BlocProvider.of<ConnectionModeBloc>(context)
                      .add(const ConnectionModeChanged(ConnectionMode.online));
                },
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/company_logo.webp',
                      height: 40,
                      color: const Color(0xFF343a40),
                    ),
                    const Spacer(),
                    Text(
                      GetIt.I<GlobalConfiguration>().getValue('app_name') ?? '',
                      style: const TextStyle(color: Color(0xFF343a40)),
                    ),
                  ],
                ),
                pinned: true,
                primary: false,
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 230,
                pinned: false,
                primary: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(Dimens.dp20),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Padding(
                    padding: const EdgeInsets.all(Dimens.dp16),
                    child: BlocBuilder<ClockOfflineButtonTypeBloc,
                        ClockOfflineButtonTypeState>(
                      builder: (context, state) {
                        return HeaderClockSection(
                          state: state,
                          onTapClockIn: () async {
                            final type = await _showOptionClockIn();
                            if (type is WorkingFromType) {
                              Navigator.of(context).pushNamed(
                                  '/attendance/offline/take-photo',
                                  arguments: {
                                    'working_from': type,
                                  }).then((_) => _fetchData());
                            }
                          },
                          onTapClockOut: () {
                            Navigator.of(context).pushNamed(
                              '/attendance/offline/take-photo',
                              arguments: {
                                'clock_out': true,
                                'working_from': state.workingFrom,
                              },
                            ).then((_) => _fetchData());
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SliverList(
                delegate: SliverChildListDelegate.fixed([
                  SizedBox(height: Dimens.dp24),
                  PendingAttendanceSection(),
                  SizedBox(height: Dimens.dp50),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<WorkingFromType?> _showOptionClockIn() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.dp24),
          ListTile(
            leading: const Icon(Icons.apartment_rounded),
            title: SubTitle1Text(S.of(context).work_from_office),
            onTap: () {
              Navigator.of(context).pop(WorkingFromType.office);
            },
          ),
          ListTile(
            leading: const Icon(Icons.public_rounded),
            title: SubTitle1Text(S.of(context).work_from_anywhere),
            onTap: () {
              Navigator.of(context).pop(WorkingFromType.anywhere);
            },
          ),
          const SizedBox(height: Dimens.dp32),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
