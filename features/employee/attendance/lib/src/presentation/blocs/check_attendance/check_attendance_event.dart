part of 'check_attendance_bloc.dart';

abstract class CheckAttendanceEvent extends Equatable {
  const CheckAttendanceEvent();
}

class FetchCheckAttendanceEvent extends CheckAttendanceEvent {
  final AttendanceType type;
  final DateTime date;
  final WorkingFromType workingFrom;

  const FetchCheckAttendanceEvent({
    required this.type,
    required this.date,
    required this.workingFrom,
  });

  @override
  List<Object> get props => [type, date, workingFrom];
}
