import '../../../attendance.dart';

class AttendanceDetailDataEntity {
  final List<AttendanceDetailEntity> attendances;
  final String? totalHours;

  AttendanceDetailDataEntity({
    required this.attendances,
    this.totalHours,
  });
}
