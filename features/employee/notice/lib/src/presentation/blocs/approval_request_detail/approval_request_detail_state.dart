part of 'approval_request_detail_bloc.dart';

abstract class ApprovalRequestDetailEvent extends Equatable {
  const ApprovalRequestDetailEvent();
}

class FetchApprovalRequestDetailEvent extends ApprovalRequestDetailEvent {
  final int id;
  final String type;

  const FetchApprovalRequestDetailEvent(this.id, this.type);

  @override
  List<Object> get props => [id];
}
