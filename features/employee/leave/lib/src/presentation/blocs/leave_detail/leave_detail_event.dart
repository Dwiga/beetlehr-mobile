part of 'leave_detail_bloc.dart';

abstract class LeaveDetailEvent extends Equatable {}

class FetchLeaveDetailEvent extends LeaveDetailEvent {
  final int id;

  FetchLeaveDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
