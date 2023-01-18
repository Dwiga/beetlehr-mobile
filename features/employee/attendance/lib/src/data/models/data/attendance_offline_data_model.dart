import 'package:attendance/attendance.dart';
import 'package:dependencies/dependencies.dart';

class AttendanceOfflineDataModel extends AttendanceOfflineDataEntity {
  const AttendanceOfflineDataModel({
    required DateTime date,
    AttendanceOfflineModel? clockIn,
    AttendanceOfflineModel? clockOut,
  }) : super(date: date, clockIn: clockIn, clockOut: clockOut);

  factory AttendanceOfflineDataModel.fromJson(Map<String, dynamic> json) {
    return AttendanceOfflineDataModel(
      date: DateTime.parse(json['date']),
      clockIn: json['clock_in'] != null
          ? AttendanceOfflineModel.fromJson(json['clock_in'])
          : null,
      clockOut: json['clock_out'] != null
          ? AttendanceOfflineModel.fromJson(json['clock_out'])
          : null,
    );
  }
}

extension AttendanceOfflineDataModelX on AttendanceOfflineDataEntity {
  Map<String, dynamic> toJson() {
    return {
      'date': DateFormat('yyyy-MM-dd').format(date),
      'clock_in': clockIn?.toJson(),
      'clock_out': clockOut?.toJson(),
    };
  }
}
