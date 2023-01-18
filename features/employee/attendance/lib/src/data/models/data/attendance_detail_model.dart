import 'package:core/core.dart';

import '../../../../attendance.dart';

class AttendanceDetailModel extends AttendanceDetailEntity {
  const AttendanceDetailModel({
    int? id,
    required String date,
    required String clock,
    String? clockGmt,
    required AttendanceClockType? type,
    AttendanceImageModel? image,
    required double latitude,
    required double longitude,
    String? address,
    String? notes,
    String? scheduleClock,
    String? scheduleClockGmt,
    bool? isLate,
    List<String>? files,
  }) : super(
          id: id,
          date: date,
          clock: clock,
          clockGmt: clockGmt,
          type: type,
          image: image,
          latitude: latitude,
          longitude: longitude,
          address: address,
          notes: notes,
          scheduleClock: scheduleClock,
          scheduleClockGmt: scheduleClockGmt,
          isLate: isLate,
          files: files,
        );

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailModel(
      id: json["id"] ?? 0,
      date: json["date"],
      clock: json["clock"],
      clockGmt: json["clock_gmt"],
      type: attendanceClockTypefromString(json['type']) ??
          AttendanceClockType.clockIn,
      image: json["image"] != null
          ? AttendanceImageModel.fromJson(json["image"])
          : null,
      latitude: Utils.doubleParser(json["latitude"]) ?? 0,
      longitude: Utils.doubleParser(json["longitude"]) ?? 0,
      address: json["address"],
      notes: json["notes"],
      scheduleClock: json["schedule_clock"],
      scheduleClockGmt: json["schedule_clock_gmt"],
      isLate: json["is_late"],
      files: json['files'] != null
          ? List<String>.from(json['files']).toList()
          : null,
    );
  }
}

extension AttendanceDetailModelX on AttendanceDetailEntity {
  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "clock": clock,
        "clock_gmt": clockGmt,
        "type": type?.convertToString(),
        "image": image?.toJson(),
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "notes": notes,
        "schedule_clock": scheduleClock,
        "schedule_clock_gmt": scheduleClockGmt,
        "is_late": isLate,
        "files": files,
      };
}
