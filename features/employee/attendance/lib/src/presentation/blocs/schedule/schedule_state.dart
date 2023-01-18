part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleLoading extends ScheduleState {}

class ScheduleSuccess extends ScheduleState {
  final List<ScheduleEntity> data;

  const ScheduleSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ScheduleFailure extends ScheduleState {
  final Failure failure;

  const ScheduleFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
