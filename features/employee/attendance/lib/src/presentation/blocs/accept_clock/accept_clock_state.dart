part of 'accept_clock_bloc.dart';

abstract class AcceptClockState extends Equatable {
  const AcceptClockState();
}

class AcceptClockInitial extends AcceptClockState {
  @override
  List<Object> get props => [];
}

class AcceptClockLoading extends AcceptClockState {
  @override
  List<Object> get props => [];
}

class AcceptClockSuccess extends AcceptClockState {
  final ClockAcceptModel data;

  const AcceptClockSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class AcceptClockFailure extends AcceptClockState {
  final Failure failure;

  const AcceptClockFailure(this.failure);
  @override
  List<Object> get props => [];
}
