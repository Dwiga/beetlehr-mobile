import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../notice.dart';

// ignore: one_member_abstracts
abstract class NoticeApiDataSource {
  Future<NoticeBoardResponseModel> getNoticeBoard(
      {required int page, required int perPage});

  Future<ApprovalRequestResponseModel> getAllApprovalRequest(
      {required int perPage,
      required int page,
      required String sortBy,
      required String? requestType,
      required String? startTime,
      required String? endTime,
      required String? employee,
      required ApprovalRequestType? status});

  Future<ApprovalRequestDetailResponseModel> getApprovalRequestDetail(
      int id, String type);

  Future<ApproverRequestResponseModel> approveRequest(
      Map<String, dynamic> body, int id);

  Future<ApproverRequestResponseModel> rejectRequest(
      Map<String, dynamic> body, int id);

  Future<NotificationResponseModel> getNotification();

  Future<NotificationDetailResponseModel> getNotificationDetail(int id);

  Future<EmployeeNameFilterResponseModel> getEmployeeNameFilter(
      {required int perPage, required int page, required String name});
}

class NoticeApiDataSourceImpl implements NoticeApiDataSource {
  /// Http clint DIO
  final Dio dio;

  NoticeApiDataSourceImpl(this.dio);

  @override
  Future<NoticeBoardResponseModel> getNoticeBoard(
      {required int page, required int perPage}) async {
    try {
      final response = await dio.get(
        '/employee/notice-board',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );
      return NoticeBoardResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ApprovalRequestResponseModel> getAllApprovalRequest(
      {required int perPage,
      required int page,
      required String sortBy,
      required String? requestType,
      required String? startTime,
      required String? endTime,
      required String? employee,
      required ApprovalRequestType? status}) async {
    try {
      final response = await dio.get(
        '/employee/approvals',
        queryParameters: {
          'per_page': perPage,
          'page': page,
          'order_by': sortBy,
          'request_type': requestType,
          'start_time': startTime,
          'end_time': endTime,
          'employees': employee,
          'status': status?.convertToString()
        },
      );
      return ApprovalRequestResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ApprovalRequestDetailResponseModel> getApprovalRequestDetail(
      int id, String type) async {
    try {
      final response = await dio.get(
        '/employee/approvals/$id',
        queryParameters: {
          'type': type,
        },
      );
      return ApprovalRequestDetailResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ApproverRequestResponseModel> approveRequest(
      Map<String, dynamic> body, int id) async {
    try {
      final response =
          await dio.put('/employee/approvals/$id/approve', data: body);
      return ApproverRequestResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ApproverRequestResponseModel> rejectRequest(
      Map<String, dynamic> body, int id) async {
    try {
      final response =
          await dio.put('/employee/approvals/$id/reject', data: body);
      return ApproverRequestResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<NotificationResponseModel> getNotification() async {
    try {
      final response =
          await dio.get('/employee/approval-request/verify/reject');
      return NotificationResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<NotificationDetailResponseModel> getNotificationDetail(int id) async {
    try {
      final response = await dio.get('/employee/approvals/$id');
      return NotificationDetailResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<EmployeeNameFilterResponseModel> getEmployeeNameFilter(
      {required int perPage, required int page, required String name}) async {
    try {
      final response = await dio.get(
        '/employee/filter',
        queryParameters: {
          'per_page': perPage,
          'page': page,
          'employee_name': name
        },
      );
      return EmployeeNameFilterResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
