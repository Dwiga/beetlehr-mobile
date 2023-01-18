import 'package:attendance/attendance.dart';
import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:notice/notice.dart';
import 'package:preferences/preferences.dart';

import '../../presentation.dart';
import '../connection_status_section.dart';
import 'sections/sections.dart';

class HomeOnlinePage extends StatefulWidget {
  const HomeOnlinePage({Key? key}) : super(key: key);

  @override
  _HomeOnlinePageState createState() => _HomeOnlinePageState();
}

class _HomeOnlinePageState extends State<HomeOnlinePage> {
  final BreakTimeBloc _bloc = GetIt.I<BreakTimeBloc>();
  final CheckBreakTimeSettingBloc _breakTimeSettingBloc =
      GetIt.I<CheckBreakTimeSettingBloc>();
  late bool firstOpen = true;

  @override
  void initState() {
    _fetchDataFromBloc();
    super.initState();
  }

  void _fetchDataFromBloc([bool refresh = false]) {
    BlocProvider.of<AttendanceOverviewBloc>(context)
        .add(FetchAttendanceOverviewEvent(
      date: DateTime.now(),
      refresh: refresh,
    ));

    _breakTimeSettingBloc
        .add(FetchCheckBreakTimeSettingEvent(refresh: refresh));
    BlocProvider.of<NoticeBoardBloc>(context).add(FetchNoticeBoardEvent(
      page: 1,
      perPage: 10,
      refresh: refresh,
    ));
    BlocProvider.of<ScheduleBloc>(context).add(FetchScheduleEvent(
      DateTime.now(),
      refresh: refresh,
    ));

    BlocProvider.of<ClockButtonTypeBloc>(context)
        .add(ClockButtonTypeFetched(refresh: refresh));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<CancelAttendanceBloc>(),
        ),
        BlocProvider(
          create: (context) => _bloc,
        ),
        BlocProvider(
          create: (context) => _breakTimeSettingBloc,
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CheckAttendanceBloc, CheckAttendanceState>(
              listener: (context, state) {
            if (state is CheckAttendanceLoading) {
              IndicatorsUtils.showLoadingSnackBar(context);
            } else if (state is CheckAttendanceFailure) {
              IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
            } else if (state is CheckAttendanceSuccess) {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
              _navigateToAttendance(state);
            } else {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
            }
          }),
          BlocListener<AttendanceOverviewBloc, AttendanceOverviewState>(
            listener: (context, state) {
              if (state is AttendanceOverviewFailure) {
                IndicatorsUtils.showErrorSnackBar(
                    context, state.failure.message);
              }
            },
          ),
          BlocListener<NoticeBoardBloc, NoticeBoardState>(
            listener: (context, state) {
              if (state is NoticeBoardFailure) {
                IndicatorsUtils.showErrorSnackBar(
                    context, state.failure.message);
              }
            },
          ),
          BlocListener<ScheduleBloc, ScheduleState>(
            listener: (context, state) {
              if (state is ScheduleFailure) {
                IndicatorsUtils.showErrorSnackBar(
                    context, state.failure.message);
              }
            },
          ),
          BlocListener<CancelAttendanceBloc, CancelAttendanceState>(
              listener: (context, state) {
            if (state is CancelAttendanceLoading) {
              IndicatorsUtils.showLoadingSnackBar(context);
            } else if (state is CancelAttendanceFailure) {
              IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
            } else if (state is CancelAttendanceSuccess) {
              BlocProvider.of<ClockButtonTypeBloc>(context)
                  .add(const ClockButtonTypeFetched(refresh: true));
              GetIt.I<ClearSavedAttendancesUseCase>()(true);
              if (mounted) IndicatorsUtils.hideCurrentSnackBar();
            } else {
              if (mounted) IndicatorsUtils.hideCurrentSnackBar();
            }
          }),
          BlocListener<BreakTimeBloc, BreakTimeState>(
              listener: (context, state) {
            if (state is BreakTimeFailure) {
              IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
            } else if (state is BreakTimeSuccess) {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
              _validateSetupPage(state);
            } else {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
            }
          }),
          BlocListener<CheckBreakTimeSettingBloc, CheckBreakTimeSettingState>(
              listener: (context, state) {
            if (state is CheckBreakTimeSettingFailure) {
              IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
            } else if (state is CheckBreakTimeSettingSuccess) {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
            } else {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
            }
          }),
          BlocListener<ClockButtonTypeBloc, ClockButtonTypeState>(
              listener: (context, state) {
            if (state is ClockButtonTypeSuccess) {
              if (state.data.breakType == BreakType.end) {
                if (firstOpen) {
                  _checkBraeakTime(state);
                }
              }
            }
          }),
        ],
        child: RefreshIndicator(
          onRefresh: () async {
            _fetchDataFromBloc(true);
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              ConnectionStatusSection(
                ignoreOnline: true,
                onSwitchToOffline: () {
                  BlocProvider.of<ConnectionModeBloc>(context)
                      .add(const ConnectionModeChanged(ConnectionMode.offline));
                },
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/app_logo.png',
                      height: Dimens.dp30,
                    ),
                    const Spacer(),
                  ],
                ),
                pinned: true,
                primary: false,
              ),
              _buildHeader(),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<ClockButtonTypeBloc, ClockButtonTypeState>(
      builder: (context, state) {
        return SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: 230 +
              (state is ClockButtonTypeSuccess &&
                      state.data.messageType != ClockMessageType.none
                  ? 70
                  : 0) +
              (state is ClockButtonTypeSuccess &&
                      state.data.breakType != BreakType.none
                  ? 70
                  : 0),
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
              child: HeaderClockSection(
                onTapClockIn: () {
                  _showChoiceClockInSheet(AttendanceType.normal);
                },
                onTapClockOut: () {
                  _getCheckActive(
                      AttendanceType.clockOut, WorkingFromType.office);
                },
                onSlideBreakTime: () {
                  if (state is ClockButtonTypeSuccess) {
                    _retrieveStartTimeValue(state);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return SliverPadding(
      padding: const EdgeInsets.all(Dimens.horizontalPadding),
      sliver: SliverList(
          delegate: SliverChildListDelegate(
        [
          const AttendanceOverviewSection(),
          const SizedBox(height: Dimens.dp24),
          const NoticeBoardSection(),
          const SizedBox(height: Dimens.dp32),
        ],
      )),
    );
  }

  void _showChoiceClockInSheet(AttendanceType type) {
    showModalBottomSheet(
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
              Navigator.of(context).pop();
              _getCheckActive(type, WorkingFromType.office);
            },
          ),
          ListTile(
            leading: const Icon(Icons.public_rounded),
            title: SubTitle1Text(S.of(context).work_from_anywhere),
            onTap: () {
              Navigator.of(context).pop();
              _getCheckActive(type, WorkingFromType.anywhere);
            },
          ),
          const SizedBox(height: Dimens.dp32),
        ],
      ),
    );
  }

  void _getCheckActive(AttendanceType type, WorkingFromType workingFrom) {
    BlocProvider.of<CheckAttendanceBloc>(context).add(
      FetchCheckAttendanceEvent(
        type: type,
        date: DateTime.now(),
        workingFrom: workingFrom,
      ),
    );
  }

  _retrieveStartTimeValue(ClockButtonTypeSuccess state) {
    if (state.data.breakType == BreakType.end) {
      _setBreakTime(BreakTimeType.end);
    } else if (state.data.breakType == BreakType.start) {
      _setBreakTime(BreakTimeType.start);
    }
  }

  void _setBreakTime(BreakTimeType breakTime) {
    _bloc.add(FetchBreakTimeEvent(
        date: DateTime.now(),
        clock: DateTime.now(),
        type: breakTime,
        files: const []));
  }

  void _navigateToAttendance(CheckAttendanceSuccess state) {
    switch (state.type) {
      case AttendanceType.normal:
        Navigator.pushNamed(
          context,
          '/attendance/clock-in/take-photo',
          arguments: {
            'working_from': state.workingFrom,
          },
        );
        break;

      case AttendanceType.clockOut:
        Navigator.pushNamed(
          context,
          '/attendance/clock-out/take-photo',
          arguments: {
            'working_from': state.workingFrom,
          },
        );
        break;
      default:
        break;
    }
    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
  }

  @override
  void dispose() {
    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
    super.dispose();
  }

  _validateSetupPage(BreakTimeSuccess state) {
    if (state.data.type == BreakTimeType.end) {
      BlocProvider.of<ClockButtonTypeBloc>(context).add(
        const ClockButtonTypeFetched(refresh: true),
      );
    } else {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const BreakTimePage(
            startBreakTime: null,
          ),
        ),
      ).then((_) => firstOpen = false).then(
            (_) => BlocProvider.of<ClockButtonTypeBloc>(context).add(
              const ClockButtonTypeFetched(refresh: true),
            ),
          );
    }
  }

  _checkBraeakTime(ClockButtonTypeSuccess state) {
    firstOpen = false;
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: BreakTimePage(startBreakTime: state.data.startBreakTime),
      ),
    ).then(
      (_) => BlocProvider.of<ClockButtonTypeBloc>(context).add(
        const ClockButtonTypeFetched(refresh: true),
      ),
    );
  }
}
