import 'package:dependencies/dependencies.dart';

class AttendanceOverviewEntity extends Equatable {
  final int present;
  final int clockoutEarly;
  final int lates;
  final int absent;
  final int holiday;
  final Duration totalWorkHours;
  final Duration totalLateHours;
  final Duration totalEarlyHours;
  final Duration totalAbsentHours;
  final int totalLeaves;
  final int totalRemainingLeaves;

  const AttendanceOverviewEntity({
    required this.present,
    required this.clockoutEarly,
    required this.lates,
    required this.absent,
    required this.holiday,
    required this.totalWorkHours,
    required this.totalLateHours,
    required this.totalEarlyHours,
    required this.totalAbsentHours,
    required this.totalLeaves,
    required this.totalRemainingLeaves,
  });

  @override
  List<Object> get props => [
        present,
        clockoutEarly,
        lates,
        absent,
        holiday,
        totalWorkHours,
        totalLateHours,
        totalEarlyHours,
        totalAbsentHours,
        totalLeaves,
        totalRemainingLeaves,
      ];

  @override
  bool get stringify => true;
}
