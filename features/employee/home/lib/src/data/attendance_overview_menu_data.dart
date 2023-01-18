import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

class AttendanceOverviewMenuData {
  static List<Map> getMenu(AttendanceOverviewEntity data) {
    var _data = <Map>[];

    _data.add({
      'type': AttendanceLogType.present,
      'color': StaticColors.green,
      'value': (data.present).toString(),
      'label': S.current.present,
      'sub_value': getDurationLabelAttendanceOverview(data.totalWorkHours),
    });
    _data.add({
      'type': AttendanceLogType.earlyClockOut,
      'color': StaticColors.orange,
      'value': (data.clockoutEarly).toString(),
      'label': S.current.clock_ot_early,
      'sub_value': getDurationLabelAttendanceOverview(data.totalEarlyHours),
    });
    _data.add({
      'type': AttendanceLogType.late,
      'color': StaticColors.blue,
      'value': (data.lates).toString(),
      'label': S.current.late,
      'sub_value': getDurationLabelAttendanceOverview(data.totalLateHours),
    });
    _data.add({
      'type': AttendanceLogType.leave,
      'color': StaticColors.lightBlue,
      'value': (data.totalLeaves).toString(),
      'label': S.current.leave,
      'sub_value': '${data.totalLeaves} ${S.current.days} '
          '(${S.current.remaining(data.totalRemainingLeaves)})',
    });
    _data.add({
      'type': AttendanceLogType.absent,
      'color': StaticColors.red,
      'value': (data.absent).toString(),
      'label': S.current.absent,
      'sub_value': '${data.absent} ${S.current.days}',
    });
    _data.add({
      'type': AttendanceLogType.holiday,
      'color': StaticColors.indigo,
      'value': (data.holiday).toString(),
      'label': S.current.holiday,
      'sub_value': '${data.holiday} ${S.current.days}',
    });

    return _data;
  }

  static String getDurationLabelAttendanceOverview(Duration duration) {
    var hours = 0;
    var minutes = 0;

    final durationInString = Utils.durationTimeToString(duration)!.split(':');

    hours = Utils.intParser(durationInString.first) ?? 0;
    minutes = Utils.intParser(durationInString[1]) ?? 0;

    return '$hours ${S.current.hours} $minutes ${S.current.minutes}';
  }
}
