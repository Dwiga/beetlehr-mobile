part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class FetchScheduleEvent extends ScheduleEvent {
  final DateTime date;
  final bool refresh;

  const FetchScheduleEvent(this.date, {this.refresh = false});

  @override
  List<Object> get props => [date, refresh];
}
