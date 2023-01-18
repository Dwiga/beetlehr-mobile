import 'dart:async';
import 'dart:developer';
import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';
import 'package:dependencies/dependencies.dart';
import 'package:attendance/attendance.dart';

class BreakPage extends StatefulWidget {
  const BreakPage({
    Key? key,
    this.startBreakTime,
  }) : super(key: key);

  final String? startBreakTime;

  @override
  _BreakPageState createState() => _BreakPageState();
}

class _BreakPageState extends State<BreakPage> {
  final BreakTimeBloc _breakTimeBloc = GetIt.I<BreakTimeBloc>();
  final CheckBreakTimeSettingBloc _breakTimeSettingBloc =
      GetIt.I<CheckBreakTimeSettingBloc>();
  final CheckAttendanceBloc _checkAttendanceBloc =
      GetIt.I<CheckAttendanceBloc>();
  Duration _duration = const Duration();
  Timer? _timer;
  late DateTime _lastStartBreakDateTime;

  @override
  void initState() {
    _fetchBreakTimeSettingFromBloc();
    _retrieveStartTimeValue();
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _breakTimeBloc,
        ),
        BlocProvider(
          create: (context) => _breakTimeSettingBloc,
        ),
        BlocProvider(
          create: (context) => _checkAttendanceBloc,
        ),
      ],
      child: BlocListener<CheckAttendanceBloc, CheckAttendanceState>(
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
        },
        child: Column(
          children: [
            const SizedBox(
              height: Dimens.dp24,
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.topCenter, child: _buildBreakTime()),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: _buildBackToWorkActivity()),
            const SizedBox(height: Dimens.dp32)
          ],
        ),
      ),
    );
  }

  void _fetchBreakTimeSettingFromBloc() {
    _breakTimeSettingBloc.add(
      const FetchCheckBreakTimeSettingEvent(),
    );
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

  Widget _buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildTimeCard(time: "$hours:"),
      _buildTimeCard(time: "$minutes:"),
      _buildTimeCard(time: seconds),
    ]);
  }

  Widget _buildTimeCard({required String time}) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            time,
            style: const TextStyle(color: Colors.white, fontSize: 50),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      );

  Widget _buildBreakTime() {
    return BlocBuilder<CheckBreakTimeSettingBloc, CheckBreakTimeSettingState>(
        builder: (context, state) {
      if (state is CheckBreakTimeSettingSuccess && state.isCanClosePage) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Center(
            child: Text(
              S.of(context).break_time,
              style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: Dimens.dp16),
            ),
          ),
          const SizedBox(height: Dimens.dp36),
          Center(
            child: _buildTime(),
          ),
          Container(
            child: _buildWarning(),
            margin: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: PrimaryButton(
                onPressed: () {
                  _getCheckActive(
                      AttendanceType.clockOut, WorkingFromType.office);
                },
                color: Colors.white,
                child: Text(S.of(context).clock_out,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: StaticColors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimens.dp14)),
              ),
            ),
          ),
        ]);
      }

      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(
            height: Dimens.dp48,
          ),
          Center(
            child: Text(
              S.of(context).break_time,
              style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: Dimens.dp16),
            ),
          ),
          const SizedBox(height: Dimens.dp36),
          Center(
            child: _buildTime(),
          ),
          Container(
            child: _buildWarning(),
            margin: const EdgeInsets.only(
                right: Dimens.dp16, left: Dimens.dp16, bottom: Dimens.dp16),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding:
                  const EdgeInsets.only(left: Dimens.dp16, right: Dimens.dp16),
              child: PrimaryButton(
                onPressed: () {
                  _getCheckActive(
                      AttendanceType.clockOut, WorkingFromType.office);
                },
                color: Colors.white,
                child: Text(S.of(context).clock_out,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: StaticColors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimens.dp14)),
              ),
            ),
          ),
        ]),
      );
    });
  }

  void _getCheckActive(AttendanceType type, WorkingFromType workingFrom) {
    _checkAttendanceBloc.add(
      FetchCheckAttendanceEvent(
        type: type,
        date: DateTime.now(),
        workingFrom: workingFrom,
      ),
    );
  }

  Widget _buildWarning() {
    return BlocBuilder<ClockButtonTypeBloc, ClockButtonTypeState>(
      builder: (context, state) {
        if (state is ClockButtonTypeSuccess &&
            state.data.messageType != ClockMessageType.none) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFfff8e5).withOpacity(1),
              borderRadius: BorderRadius.circular(Dimens.dp8),
              border: Border.all(color: StaticColors.yellow),
            ),
            margin: const EdgeInsets.only(top: Dimens.dp8),
            padding: const EdgeInsets.all(Dimens.dp8),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitle1Text(
                      S
                          .of(context)
                          .warning_home_attendance_without_schedule_title,
                      style: const TextStyle(fontSize: Dimens.dp14),
                    ),
                    const SizedBox(height: Dimens.dp8),
                    Text(
                      state.data.messageType.toWaringMessage(context),
                      style: const TextStyle(
                        fontSize: Dimens.dp12,
                      ),
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: StaticColors.yellow,
                    size: Dimens.dp16,
                  ),
                )
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTimer());
  }

  void _stopTimer() {
    setState(() => _timer?.cancel());
  }

  void _updateTimer() {
    _duration = DateTime.now().difference(_lastStartBreakDateTime);
    if (mounted) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds);
      });
    }
  }

  _retrieveStartTimeValue() {
    final lastStartBreakTime = widget.startBreakTime;
    if (lastStartBreakTime != null) {
      _lastStartBreakDateTime = DateTime.parse(
          DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
              " " +
              lastStartBreakTime);
    } else {
      _lastStartBreakDateTime = DateTime.now();
    }
    _lastStartBreakDateTime = lastStartBreakTime != null
        ? DateTime.parse(
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
                " " +
                lastStartBreakTime)
        : DateTime.now();
    log(_lastStartBreakDateTime.toString());
    _duration = DateTime.now().difference(_lastStartBreakDateTime);
  }

  Widget _buildBackToWorkActivity() {
    return BlocListener<BreakTimeBloc, BreakTimeState>(
      listener: (context, state) {
        if (state is BreakTimeFailure) {
          IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
        } else if (state is BreakTimeSuccess) {
          if (mounted) {
            IndicatorsUtils.hideCurrentSnackBar();
          }
          Navigator.of(context).pop();
        } else {
          if (mounted) {
            IndicatorsUtils.hideCurrentSnackBar();
          }
        }
      },
      child: Container(
        height: Dimens.dp48,
        width: (MediaQuery.of(context).size.width - Dimens.dp36),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: const Color(0xff1B4FAA)),
        child: SlideAction(
          key: widget.key,
          onSubmit: () {
            _stopTimer();
            _breakTimeBloc.add(
              FetchBreakTimeEvent(
                  date: DateTime.now(),
                  clock: DateTime.now(),
                  type: BreakTimeType.end,
                  files: const []),
            );
          },
          innerColor: Colors.white,
          outerColor: const Color(0xff1B4FAA),
          text: S.of(context).back_to_work,
          borderRadius: 24,
          textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          sliderButtonYOffset: -1,
          sliderRotate: false,
          sliderButtonIconPadding: 10,
          height: 24,
          elevation: 0,
          alignment: Alignment.center,
          submittedIcon: const CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Colors.white,
          ),
          sliderButtonIcon: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xff1B4FAA),
            size: 16,
          ),
        ),
      ),
    );
  }
}

extension _ClockMessageTypeX on ClockMessageType {
  String toWaringMessage(BuildContext context) {
    switch (this) {
      case ClockMessageType.clockIn:
        return S
            .of(context)
            .warning_home_attendance_clock_in_without_schedule_subtitle;
      case ClockMessageType.clockOut:
        return S
            .of(context)
            .warning_home_attendance_clock_out_without_schedule_subtitle;
      case ClockMessageType.alreadyAttendance:
        return S
            .of(context)
            .warning_home_attendance_alread_attendance_without_schedule_subtitle;
      default:
        return '';
    }
  }
}
