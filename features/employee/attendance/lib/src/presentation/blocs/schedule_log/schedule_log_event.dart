part of 'schedule_log_bloc.dart';

abstract class ScheduleLogEvent extends Equatable {}

class FetchScheduleLogEvent extends ScheduleLogEvent {
  final DateTime startDate;
  final DateTime endDate;

  FetchScheduleLogEvent({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}
