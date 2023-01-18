import 'package:dependencies/dependencies.dart';

import '../../../attendance.dart';

class AttendanceDetailEntity extends Equatable {
  final int? id;
  final String date;
  final String clock;
  final String? clockGmt;
  final AttendanceClockType? type;
  final AttendanceImageEntity? image;
  final double latitude;
  final double longitude;
  final String? address;
  final String? notes;
  final String? scheduleClock;
  final String? scheduleClockGmt;
  final bool? isLate;
  final List<String>? files;

  const AttendanceDetailEntity({
    required this.id,
    required this.date,
    required this.clock,
    this.clockGmt,
    required this.type,
    required this.image,
    required this.latitude,
    required this.longitude,
    this.address,
    this.notes,
    this.scheduleClock,
    this.scheduleClockGmt,
    this.isLate,
    this.files,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        clock,
        clockGmt,
        type,
        image,
        latitude,
        longitude,
        address,
        notes,
        scheduleClock,
        scheduleClockGmt,
        isLate,
        files,
      ];

  @override
  bool get stringify => true;
}
