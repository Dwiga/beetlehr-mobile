import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../notice.dart';

class GetApprovalRequestUseCase
    implements
        UseCase<PaginateData<List<ApprovalRequestEntity>, MetaData>,
            ApprovalRequestParams> {
  final NoticeRepository repository;

  GetApprovalRequestUseCase(this.repository);
  @override
  Future<Either<Failure, PaginateData<List<ApprovalRequestEntity>, MetaData>>>
      call(ApprovalRequestParams params) async {
    return await repository.getAllApprovalRequest(
        perPage: params.perPage,
        page: params.page,
        sortBy: params.orderBy,
        requestType: params.requestType,
        startTime: params.startTime,
        endTime: params.endTime,
        employee: params.employee,
        status: params.status);
  }
}

class ApprovalRequestParams {
  final int perPage;
  final int page;
  final String orderBy;
  final String? requestType;
  final String? startTime;
  final String? endTime;
  final String? employee;
  final ApprovalRequestType? status;

  ApprovalRequestParams(
      {required this.perPage,
      required this.page,
      required this.orderBy,
      this.requestType,
      this.startTime,
      this.endTime,
      this.employee,
      this.status});
}
