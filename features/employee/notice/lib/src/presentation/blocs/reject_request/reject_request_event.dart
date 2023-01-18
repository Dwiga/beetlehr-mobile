part of 'reject_request_bloc.dart';

abstract class RejectRequestEvent extends Equatable {
  const RejectRequestEvent();
}

class FetchRejectRequestEvent extends RejectRequestEvent {
  final int id;
  final ApproverRequestBodyModel body;

  const FetchRejectRequestEvent({
    required this.id,
    required this.body,
  });

  @override
  List<Object> get props => [id, body];
}
