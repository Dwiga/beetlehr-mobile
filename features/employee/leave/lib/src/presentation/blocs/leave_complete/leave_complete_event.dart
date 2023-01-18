part of 'leave_complete_bloc.dart';

abstract class LeaveCompleteEvent extends Equatable {
  const LeaveCompleteEvent();
}

class FetchLeaveCompleteEvent extends LeaveCompleteEvent {
  final int page;
  final int perPage;

  const FetchLeaveCompleteEvent({required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
