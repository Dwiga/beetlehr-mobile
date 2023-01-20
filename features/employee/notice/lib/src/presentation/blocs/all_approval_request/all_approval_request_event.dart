part of 'all_approval_request_bloc.dart';

abstract class AllApprovalRequestEvent extends Equatable {}

class FetchAllApprovalRequestEvent extends AllApprovalRequestEvent {
  final int perPage;
  final int page;
  final String? sortBy;
  final String? requestType;
  final String? startTime;
  final String? endTime;
  final String? employee;
  final ApprovalRequestType? status;

  FetchAllApprovalRequestEvent(
      {required this.perPage,
      required this.page,
      required this.sortBy,
      this.requestType,
      required this.startTime,
      required this.endTime,
      this.employee,
      required this.status});

  @override
  List<Object?> get props => [
        perPage,
        page,
        sortBy,
        requestType,
        startTime,
        endTime,
        employee,
        status
      ];

  @override
  bool get stringify => true;
}
