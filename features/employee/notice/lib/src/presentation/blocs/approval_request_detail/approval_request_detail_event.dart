part of 'approval_request_detail_bloc.dart';

abstract class ApprovalRequestDetailState extends Equatable {
  const ApprovalRequestDetailState();
}

class AttendanceDetailLoading extends ApprovalRequestDetailState {
  @override
  List<Object> get props => [];
}

class ApprovalRequestDetailSuccess extends ApprovalRequestDetailState {
  final ApprovalRequestDetailEntity data;

  const ApprovalRequestDetailSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ApprovalRequestDetailFailure extends ApprovalRequestDetailState {
  final Failure failure;

  const ApprovalRequestDetailFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
