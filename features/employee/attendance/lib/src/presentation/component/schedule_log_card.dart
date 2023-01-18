import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../attendance.dart';

class ScheduleLogCard extends StatelessWidget {
  final ScheduleEntity data;

  const ScheduleLogCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildDate(context),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: Dimens.dp24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.name != null) ...[
                  Row(
                    children: [
                      const Text(
                        'Shift: ',
                        style: TextStyle(fontSize: Dimens.dp10),
                      ),
                      Text(
                        data.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimens.dp10,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: Dimens.dp8),
                ],
                Row(
                  children: [
                    _buildClockIn(context),
                    _buildClockOut(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDate(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.dp8,
          horizontal: Dimens.dp12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmallText(
              DateFormat('E').format(data.date).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            SubTitle1Text(
              DateFormat('dd').format(data.date),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClockIn(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClockLabel(context, S.of(context).clock_in),
          const SizedBox(height: Dimens.dp4),
          SubTitle2Text(
              _timeClockDurationParse(Utils.durationTimeParse(data.timeStart)),
              style: TextStyle(color: Theme.of(context).primaryColor)),
        ],
      ),
    );
  }

  Widget _buildClockOut(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClockLabel(context, S.of(context).clock_out),
          const SizedBox(height: Dimens.dp4),
          SubTitle2Text(
              _timeClockDurationParse(Utils.durationTimeParse(data.timeEnd)),
              style: const TextStyle(color: StaticColors.red)),
        ],
      ),
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
}
