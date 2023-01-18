part of 'break_time_bloc.dart';

abstract class BreakTimeState extends Equatable {
  const BreakTimeState();
}

class BreakTimeInitial extends BreakTimeState {
  @override
  List<Object> get props => [];
}

class BreakTimeLoading extends BreakTimeState {
  @override
  List<Object> get props => [];
}

class BreakTimeSuccess extends BreakTimeState {
  final BreakTimeModel data;

  const BreakTimeSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BreakTimeFailure extends BreakTimeState {
  final Failure failure;

  const BreakTimeFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
