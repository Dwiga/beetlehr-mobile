part of 'leave_detail_bloc.dart';

abstract class LeaveDetailState extends Equatable {}

class LeaveDetailLoading extends LeaveDetailState {
  @override
  List<Object> get props => [];
}

class LeaveDetailSuccess extends LeaveDetailState {
  final LeaveDetailEntity data;
  LeaveDetailSuccess(this.data);
  @override
  List<Object> get props => [data];
}

class LeaveDetailFailure extends LeaveDetailState {
  final Failure failure;

  LeaveDetailFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
