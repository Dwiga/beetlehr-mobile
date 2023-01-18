import 'package:attendance/attendance.dart';
import 'package:dependencies/dependencies.dart';

class AttendanceOfflineDataEntity extends Equatable {
  final DateTime date;
  final AttendanceOfflineEntity? clockIn;
  final AttendanceOfflineEntity? clockOut;

  const AttendanceOfflineDataEntity({
    required this.date,
    this.clockIn,
    this.clockOut,
  });

  AttendanceOfflineDataEntity copyWith({
    DateTime? date,
    AttendanceOfflineEntity? clockIn,
    AttendanceOfflineEntity? clockOut,
  }) {
    return AttendanceOfflineDataEntity(
      date: date ?? this.date,
      clockIn: clockIn ?? this.clockIn,
      clockOut: clockOut ?? this.clockOut,
    );
  }

  @override
  List<Object?> get props => [date, clockIn, clockOut];
}
