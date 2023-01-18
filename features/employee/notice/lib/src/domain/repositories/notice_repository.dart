import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../notice.dart';

// ignore: one_member_abstracts
abstract class NoticeRepository {
  Future<Either<Failure, PaginateData<List<NoticeEntity>, MetaData>>>
      getNoticeBoard({required int page, required int perPage});

  Future<Either<Failure, PaginateData<List<ApprovalRequestEntity>, MetaData>>>
      getAllApprovalRequest(
          {required int perPage,
          required int page,
          required String sortBy,
          required String? requestType,
          required String? startTime,
          required String? endTime,
          required String? employee,
          required ApprovalRequestType? status});

  Future<Either<Failure, ApprovalRequestDetailEntity>> getApprovalRequestDetail(
      int id, String type);

  Future<Either<Failure, ApproverResponseEntity>> approveRequest(
      ApproverRequestBodyModel body, int id);

  Future<Either<Failure, ApproverResponseEntity>> rejectRequest(
      ApproverRequestBodyModel body, int id);

  Future<Either<Failure, PaginateData<List<NotificationEntity>, MetaData>>>
      getNotification();

  Future<Either<Failure, NotificationDetailEntity>> getNotificationDetail(
      int id);

  Future<
          Either<Failure,
              PaginateData<List<EmployeeNameFilterEntity>, MetaData>>>
      getEmployeeNameFilter({
    required int perPage,
    required int page,
    required String name,
  });
}
