part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

class GetAttendanceEvent extends AttendanceEvent {
  final ClockBodyModel data;

  const GetAttendanceEvent(this.data);

  @override
  List<Object> get props => [data];
}
