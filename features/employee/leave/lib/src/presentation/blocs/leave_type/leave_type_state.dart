part of 'leave_type_bloc.dart';

abstract class LeaveTypeState extends Equatable {}

class LeaveTypeLoading extends LeaveTypeState {
  @override
  List<Object> get props => [];
}

class LeaveTypeSuccess extends LeaveTypeState {
  final List<LeaveTypeEntity> data;

  LeaveTypeSuccess(this.data);
  @override
  List<Object> get props => [data];
}

class LeaveTypeFailure extends LeaveTypeState {
  final Failure failure;

  LeaveTypeFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
