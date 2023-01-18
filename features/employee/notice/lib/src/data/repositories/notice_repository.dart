import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../notice.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeApiDataSource apiDataSource;
  NoticeRepositoryImpl({
    required this.apiDataSource,
  });

  @override
  Future<Either<Failure, PaginateData<List<NoticeEntity>, MetaData>>>
      getNoticeBoard({required int page, required int perPage}) async {
    try {
      final result =
          await apiDataSource.getNoticeBoard(page: page, perPage: perPage);

      return Right(PaginateData(
        data: result.data,
        meta: result.meta!,
      ));
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, PaginateData<List<ApprovalRequestEntity>, MetaData>>>
      getAllApprovalRequest(
          {required int perPage,
          required int page,
          required String sortBy,
          required String? requestType,
          required String? startTime,
          required String? endTime,
          required String? employee,
          required ApprovalRequestType? status}) async {
    try {
      final result = await apiDataSource.getAllApprovalRequest(
          perPage: perPage,
          page: page,
          sortBy: sortBy,
          requestType: requestType,
          startTime: startTime,
          endTime: endTime,
          employee: employee,
          status: status);

      return Right(PaginateData(
        data: result.data,
        meta: result.meta!,
      ));
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, ApprovalRequestDetailEntity>> getApprovalRequestDetail(
      int id, String type) async {
    try {
      final result = await apiDataSource.getApprovalRequestDetail(id, type);
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, ApproverResponseEntity>> approveRequest(
      ApproverRequestBodyModel body, int id) async {
    try {
      final result = await apiDataSource.approveRequest(body.toJson(), id);
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, ApproverResponseEntity>> rejectRequest(
      ApproverRequestBodyModel body, int id) async {
    try {
      final result = await apiDataSource.rejectRequest(body.toJson(), id);
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, PaginateData<List<NotificationEntity>, MetaData>>>
      getNotification() async {
    try {
      final result = await apiDataSource.getNotification();

      return Right(PaginateData(
        data: result.data,
        meta: result.meta!,
      ));
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, NotificationDetailEntity>> getNotificationDetail(
      int id) async {
    try {
      final result = await apiDataSource.getNotificationDetail(id);
      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<
          Either<Failure,
              PaginateData<List<EmployeeNameFilterEntity>, MetaData>>>
      getEmployeeNameFilter({
    required int perPage,
    required int page,
    required String name,
  }) async {
    try {
      final result = await apiDataSource.getEmployeeNameFilter(
          perPage: perPage, page: page, name: name);

      return Right(PaginateData(
        data: result.data,
        meta: result.meta!,
      ));
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }
}
