import 'package:core/core.dart';

import '../../../../attendance.dart';

class AttendanceResponseModel extends AttendanceDetailModel {
  final Duration clockoutDuration;
  final Duration clockToleranceDuration;
  final Duration trackerInterval;
  final TrackerConfigModel trackerConfig;

  const AttendanceResponseModel({
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
    required this.clockoutDuration,
    required this.clockToleranceDuration,
    required this.trackerInterval,
    required this.trackerConfig,
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

  factory AttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    return AttendanceResponseModel(
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
      clockoutDuration: Utils.durationTimeParse(json['clockout_duration']) ??
          const Duration(seconds: 0),
      clockToleranceDuration:
          Utils.durationTimeParse(json['clockout_tolerance_duration']) ??
              const Duration(seconds: 0),
      trackerInterval: Utils.durationTimeParse(json['tracker_interval']) ??
          const Duration(minutes: 5),
      trackerConfig: TrackerConfigModel.fromJson(json['tracker_configuration']),
    );
  }
}
