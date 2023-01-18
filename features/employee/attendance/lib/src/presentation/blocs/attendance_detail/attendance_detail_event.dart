part of 'attendance_detail_bloc.dart';

abstract class AttendanceDetailEvent extends Equatable {
  const AttendanceDetailEvent();
}

class FetchAttendanceDetailEvent extends AttendanceDetailEvent {
  final DateTime date;

  const FetchAttendanceDetailEvent(this.date);

  @override
  List<Object> get props => [date];
}
