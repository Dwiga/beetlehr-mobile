part of 'accept_clock_bloc.dart';

abstract class AcceptClockEvent extends Equatable {
  const AcceptClockEvent();
}

class GetCheckAcceptClockEvent extends AcceptClockEvent {
  final ClockBodyModel data;

  const GetCheckAcceptClockEvent(this.data);

  @override
  List<Object> get props => [data];
}
