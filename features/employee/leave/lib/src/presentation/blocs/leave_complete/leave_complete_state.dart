part of 'leave_complete_bloc.dart';

abstract class LeaveCompleteState extends Equatable {
  const LeaveCompleteState();
}

class LeaveCompleteInitial extends LeaveCompleteState {
  @override
  List<Object> get props => [];
}

class LeaveCompleteSuccess extends LeaveCompleteState {
  final List<LeaveEntity> data;
  final bool hasReachedMax;
  final int page;
  final int quota;
  const LeaveCompleteSuccess({
    required this.data,
    required this.quota,
    required this.hasReachedMax,
    required this.page,
  });

  @override
  List<Object> get props => [data, hasReachedMax, page];

  @override
  bool get stringify => true;
}

class LeaveCompleteFailure extends LeaveCompleteState {
  final Failure failure;

  const LeaveCompleteFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
