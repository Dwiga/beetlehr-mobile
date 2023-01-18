part of 'attendance_log_bloc.dart';

abstract class AttendanceLogEvent extends Equatable {}

class FetchAttendanceLogEvent extends AttendanceLogEvent {
  final DateTime period;
  final AttendanceLogType? status;

  FetchAttendanceLogEvent({
    required this.period,
    this.status,
  });

  @override
  List<Object?> get props => [period, status];
}
