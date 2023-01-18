part of 'schedule_log_bloc.dart';

abstract class ScheduleLogState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ScheduleLogLoading extends ScheduleLogState {}

class ScheduleLogSuccess extends ScheduleLogState {
  final List<ScheduleEntity> data;
  final DateTime period;

  ScheduleLogSuccess({
    required this.data,
    required this.period,
  });

  @override
  List<Object> get props => [data, period];
}

class ScheduleLogFailure extends ScheduleLogState {
  final Failure failure;

  ScheduleLogFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
