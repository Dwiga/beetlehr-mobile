import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

enum AttendanceLogCardType {
  normal,
  holiday,
  absent,
}

class AttendanceLogCard extends StatelessWidget {
  final AttendanceLogCardType type;
  final DateTime date;
  final Duration? clockInTime;
  final Duration? clockOutTime;
  final Duration? worksHours;
  final bool? isForceClockOut;
  final bool? isOvertime;

  const AttendanceLogCard({
    Key? key,
    required this.type,
    required this.date,
    this.clockInTime,
    this.clockOutTime,
    this.worksHours,
    this.isForceClockOut,
    this.isOvertime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == AttendanceLogCardType.normal) {
      return _buildNormalDay(context);
    }
    return _buildHoliday(context);
  }

  Widget _buildHoliday(BuildContext context) {
    return Row(
      children: [
        _buildDate(context),
        const SizedBox(width: Dimens.dp24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((_buildBadges(context) as Row).children.isNotEmpty) ...[
              _buildBadges(context),
              const SizedBox(height: Dimens.dp6),
            ],
            SubTitle2Text(
              type == AttendanceLogCardType.absent
                  ? S.of(context).absent
                  : S.of(context).holiday,
              style: const TextStyle(color: StaticColors.red),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildNormalDay(BuildContext context) {
    return Row(
      children: [
        _buildDate(context),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: Dimens.dp24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBadges(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildClockIn(context),
                    _buildClockOut(context),
                    _buildWorkHours(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadges(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_buildTypeBadge(context) != null) ...[_buildTypeBadge(context)!],
        if (_buildForceClockOutBadge(context) != null) ...[
          _buildForceClockOutBadge(context)!
        ],
      ],
    );
  }

  Widget? _buildTypeBadge(BuildContext context) {
    return Card(
      color: StaticColors.blue.withOpacity(0.3),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: Dimens.dp4, horizontal: 8.0),
        child: SmallText(
          'NORMAL',
          style:
              TextStyle(color: StaticColors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget? _buildForceClockOutBadge(BuildContext context) {
    if (isForceClockOut == true) {
      return Card(
        color: StaticColors.red.withOpacity(0.3),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: Dimens.dp4, horizontal: 8.0),
          child: SmallText(
            S.of(context).force_clock_out.toUpperCase(),
            style: const TextStyle(
                color: StaticColors.red, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return null;
  }

  Widget _buildDate(BuildContext context) {
    return Card(
      color: (type == AttendanceLogCardType.absent ||
              type == AttendanceLogCardType.holiday)
          ? StaticColors.red
          : Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.dp8,
          horizontal: Dimens.dp12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmallText(
              DateFormat('E').format(date).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            SubTitle1Text(
              DateFormat('dd').format(date),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClockIn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildClockLabel(context, S.of(context).clock_in),
        const SizedBox(height: Dimens.dp4),
        SubTitle2Text(_timeClockDurationParse(clockInTime),
            style: TextStyle(color: Theme.of(context).primaryColor)),
      ],
    );
  }

  Widget _buildClockOut(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildClockLabel(context, S.of(context).clock_out),
        const SizedBox(height: Dimens.dp4),
        SubTitle2Text(_timeClockDurationParse(clockOutTime),
            style: const TextStyle(color: StaticColors.red)),
      ],
    );
  }

  Widget _buildWorkHours(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildClockLabel(context, S.of(context).work_hours),
        const SizedBox(height: Dimens.dp4),
        SubTitle2Text(_timeWorksHoursDurationParse(worksHours),
            style: const TextStyle(color: StaticColors.green)),
      ],
    );
  }

  Widget _buildClockLabel(BuildContext context, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.access_time,
          size: Dimens.dp12,
          color: Theme.of(context).disabledColor,
        ),
        const SizedBox(width: Dimens.dp4),
        SmallText(
          label,
          style: TextStyle(
            color: Theme.of(context).disabledColor,
          ),
        )
      ],
    );
  }

  String _timeClockDurationParse(Duration? duration) {
    if (duration != null) {
      var result = '';
      var durationParse = duration.toString().split(':');
      result += '${durationParse.first}.';
      result += durationParse[1];
      return result;
    }
    return '-';
  }

  String _timeWorksHoursDurationParse(Duration? duration) {
    if (duration != null) {
      var result = '';
      var durationParse = duration.toString().split(':');
      result += '${durationParse.first}h ';
      result += '${durationParse[1]}m';
      return result;
    }
    return '-';
  }
}
