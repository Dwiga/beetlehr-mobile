part of 'approve_request_bloc.dart';

abstract class ApproveRequestState extends Equatable {
  const ApproveRequestState();
}

class ApproveRequestInitial extends ApproveRequestState {
  @override
  List<Object> get props => [];
}

class ApproveRequestLoading extends ApproveRequestState {
  @override
  List<Object> get props => [];
}

class ApproveRequestSuccess extends ApproveRequestState {
  final ApproverResponseEntity data;

  const ApproveRequestSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ApproveRequestFailure extends ApproveRequestState {
  final Failure failure;

  const ApproveRequestFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
