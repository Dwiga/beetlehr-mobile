part of 'leave_cancel_bloc.dart';

abstract class LeaveCancelEvent extends Equatable {}

class GetLeaveCancelEvent extends LeaveCancelEvent {
  final int id;

  GetLeaveCancelEvent(this.id);

  @override
  List<Object> get props => [id];
}
