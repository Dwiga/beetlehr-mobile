part of 'approve_request_bloc.dart';

abstract class ApproveRequestEvent extends Equatable {
  const ApproveRequestEvent();
}

class FetchApproveRequestEvent extends ApproveRequestEvent {
  final int id;
  final ApproverRequestBodyModel body;

  const FetchApproveRequestEvent({
    required this.id,
    required this.body,
  });

  @override
  List<Object> get props => [id, body];
}
