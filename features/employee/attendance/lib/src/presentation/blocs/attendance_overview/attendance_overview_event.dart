part of 'attendance_overview_bloc.dart';

abstract class AttendanceOverviewEvent extends Equatable {}

class FetchAttendanceOverviewEvent extends AttendanceOverviewEvent {
  final DateTime date;
  final bool refresh;
  FetchAttendanceOverviewEvent({
    required this.date,
    this.refresh = false,
  });

  @override
  List<Object> get props => [date, refresh];

  @override
  bool get stringify => true;
}
