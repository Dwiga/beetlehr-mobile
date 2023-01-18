part of 'all_approval_request_bloc.dart';

abstract class AllApprovalRequestState extends Equatable {
  @override
  List<Object> get props => [];
}

class AllApprovalRequestLoading extends AllApprovalRequestState {}

class AllApprovalRequestFailure extends AllApprovalRequestState {
  final Failure failure;
  AllApprovalRequestFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class AllApprovalRequestSuccess extends AllApprovalRequestState {
  final List<ApprovalRequestEntity> data;
  final bool hasReachedMax;
  final int page;

  AllApprovalRequestSuccess({
    required this.data,
    required this.hasReachedMax,
    required this.page,
  });

  @override
  List<Object> get props => [data, hasReachedMax, page];
}
