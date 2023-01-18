import 'package:dependencies/dependencies.dart';

import '../domain.dart';

class AttendanceEntity extends Equatable {
  final DateTime date;
  final String? clockIn;
  final String? clockInGmt;
  final String? clockOut;
  final String? clockOutGmt;
  final String? workHours;
  final bool? isForceClockOut;
  final AttendanceType? type;
  final AttendanceLogType? status;

  const AttendanceEntity({
    required this.date,
    required this.clockIn,
    this.clockInGmt,
    required this.clockOut,
    this.clockOutGmt,
    this.workHours,
    this.isForceClockOut,
    this.type,
    this.status,
  });

  @override
  List<Object?> get props => [
        date,
        clockIn,
        clockInGmt,
        clockOut,
        clockOutGmt,
        workHours,
        isForceClockOut,
        type,
        status,
      ];

  @override
  bool get stringify => true;
}
