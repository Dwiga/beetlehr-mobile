import 'package:dependencies/dependencies.dart';
import 'package:intl/intl.dart';

import '../../../../attendance.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required DateTime date,
    required String? clockIn,
    String? clockInGmt,
    required String? clockOut,
    String? clockOutGmt,
    String? workHours,
    bool? isForceClockOut,
    AttendanceType? type,
    AttendanceLogType? status,
  }) : super(
          date: date,
          clockIn: clockIn,
          clockInGmt: clockInGmt,
          clockOut: clockOut,
          clockOutGmt: clockOutGmt,
          workHours: workHours,
          isForceClockOut: isForceClockOut,
          type: type,
          status: status,
        );

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        date: DateTime.parse(json["date"]).toLocal(),
        clockIn: json["clock_in"],
        clockInGmt: json["clock_in_gmt"],
        clockOut: json["clock_out"],
        clockOutGmt: json["clock_out_gmt"],
        workHours: json["work_hours"],
        isForceClockOut: json["is_force_clock_out"],
        type: attendanceTypefromString(json["type"]),
        status: attendanceLogTypeFromString(json["status"]),
      );
}

extension AttendanceModelX on AttendanceEntity {
  Map<String, dynamic> toJson() => {
        "date": DateFormat('y-MM-dd').format(date),
        "clock_in": clockIn,
        "clock_in_gmt": clockInGmt,
        "clock_out": clockOut,
        "clock_out_gmt": clockOutGmt,
        "work_hours": workHours,
        "is_force_clock_out": isForceClockOut,
        "type": type?.convertToString(),
        "status": status,
      };
}
