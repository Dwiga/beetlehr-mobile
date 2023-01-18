part of 'reject_request_bloc.dart';

abstract class RejectRequestState extends Equatable {
  const RejectRequestState();
}

class RejectRequestInitial extends RejectRequestState {
  @override
  List<Object> get props => [];
}

class RejectRequestLoading extends RejectRequestState {
  @override
  List<Object> get props => [];
}

class RejectRequestSuccess extends RejectRequestState {
  final ApproverResponseEntity data;

  const RejectRequestSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class RejectRequestFailure extends RejectRequestState {
  final Failure failure;

  const RejectRequestFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
