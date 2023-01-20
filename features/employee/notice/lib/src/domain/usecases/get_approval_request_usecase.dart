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
        requestType: null,
        startTime: params.startTime,
        endTime: params.endTime,
        employee: null,
        status: params.status);
  }
}

class ApprovalRequestParams {
  final int perPage;
  final int page;
  final String orderBy;
  final String? startTime;
  final String? endTime;
  final ApprovalRequestType? status;

  ApprovalRequestParams(
      {required this.perPage,
      required this.page,
      required this.orderBy,
      this.startTime,
      this.endTime,
      this.status});
}
