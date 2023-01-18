part of 'leave_inprocess_bloc.dart';

abstract class LeaveInProcessState extends Equatable {
  const LeaveInProcessState();
}

class LeaveInProcessInitial extends LeaveInProcessState {
  @override
  List<Object> get props => [];
}

class LeaveInProcessSuccess extends LeaveInProcessState {
  final List<LeaveEntity> data;
  final bool hasReachedMax;
  final int page;
  final int quota;
  const LeaveInProcessSuccess({
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

class LeaveInProcessFailure extends LeaveInProcessState {
  final Failure failure;

  const LeaveInProcessFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
