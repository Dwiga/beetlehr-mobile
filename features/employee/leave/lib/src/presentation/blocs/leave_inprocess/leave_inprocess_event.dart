part of 'leave_inprocess_bloc.dart';

abstract class LeaveInProcessEvent extends Equatable {
  const LeaveInProcessEvent();
}

class FetchLeaveInProcessEvent extends LeaveInProcessEvent {
  final int page;
  final int perPage;

  const FetchLeaveInProcessEvent({required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
