import 'package:core/core.dart';

import '../../../../attendance.dart';

class AttendanceOverviewModel extends AttendanceOverviewEntity {
  const AttendanceOverviewModel({
    required int present,
    required int clockoutEarly,
    required int lates,
    required int absent,
    required int holiday,
    required Duration totalWorkHours,
    required Duration totalLateHours,
    required Duration totalEarlyHours,
    required Duration totalAbsentHours,
    required int totalLeaves,
    required int totalRemainingLeaves,
  }) : super(
          present: present,
          clockoutEarly: clockoutEarly,
          lates: lates,
          absent: absent,
          holiday: holiday,
          totalWorkHours: totalWorkHours,
          totalEarlyHours: totalEarlyHours,
          totalLateHours: totalLateHours,
          totalAbsentHours: totalAbsentHours,
          totalLeaves: totalLeaves,
          totalRemainingLeaves: totalRemainingLeaves,
        );

  factory AttendanceOverviewModel.fromJson(Map<String, dynamic> json) =>
      AttendanceOverviewModel(
        present: json['present'],
        clockoutEarly: json['clockout_early'],
        lates: json['late'],
        absent: json['absent'],
        holiday: json['holiday'],
        totalWorkHours: Utils.durationTimeParse(json['total_work_hours'])!,
        totalEarlyHours: Utils.durationTimeParse(json['total_early_hours'])!,
        totalLateHours: Utils.durationTimeParse(json['total_late_hours'])!,
        totalAbsentHours: Utils.durationTimeParse(json['total_absent_hours'])!,
        totalLeaves: Utils.intParser(json['total_leaves'])!,
        totalRemainingLeaves: Utils.intParser(json['total_remaining_leaves'])!,
      );
}

extension AttendanceOverviewModelX on AttendanceOverviewEntity {
  Map<String, dynamic> toJson() => {
        'present': present,
        'clockout_early': clockoutEarly,
        'late': lates,
        'absent': absent,
        'holiday': holiday,
        'total_work_hours': Utils.durationTimeToString(totalWorkHours),
        'total_late_hours': Utils.durationTimeToString(totalLateHours),
        'total_early_hours': Utils.durationTimeToString(totalEarlyHours),
        'total_absent_hours': Utils.durationTimeToString(totalAbsentHours),
        'total_leaves': totalLeaves,
        'total_remaining_leaves': totalRemainingLeaves,
      };
}
