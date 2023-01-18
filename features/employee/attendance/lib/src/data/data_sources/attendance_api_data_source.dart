import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../attendance.dart';

abstract class AttendanceApiDataSource {
  Future<AttendanceOverviewResponseModel> getAttendanceOverview(String date);

  Future<AttendanceImageResponseModel> uploadAttendanceImage(FormData body);

  Future<AttendanceLogResponseModel> getAttendanceLogs(int month, int year,
      {String? status});

  Future<CheckPlacementResponseModel> checkPlacementOffice(
      Map<String, dynamic> body);

  Future<AttendanceDetailResponseModel> getAttendanceDetail(String date);

  Future<ClockAcceptResponseModel> checkAcceptClock(Map<String, dynamic> body);

  Future<AttendanceResponseModel> clockAttendance(Map<String, dynamic> body);

  Future<ScheduleResponseModel> getSchedule(String date);

  Future<bool> checkAcceptClockAttendance(Map<String, dynamic> body);

  Future<ScheduleResponseModel> getScheduleLog(
      String startDate, String endDate);

  Future<ClockButtonModel> getClockButtonType();

  Future<bool> syncAttendances(List<Map> data);

  Future<UploadFilesResponseModel> uploadAttendanceImages(FormData data);

  Future<bool> cancelAttendance();

  Future<BreakTimeResponseModel> breakTime(Map<String, dynamic> body);

  Future<bool> checkBreakTimeSetting();
}

class AttendanceApiDataSourceImpl implements AttendanceApiDataSource {
  /// Dio HTTP client
  final Dio dio;

  AttendanceApiDataSourceImpl(this.dio);

  @override
  Future<AttendanceOverviewResponseModel> getAttendanceOverview(
      String date) async {
    try {
      final response = await dio.get('/employee/attendance-overview',
          queryParameters: {'date': date});
      return AttendanceOverviewResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<AttendanceImageResponseModel> uploadAttendanceImage(
      FormData body) async {
    try {
      final response = await dio.post('/employee/attendance-image', data: body);
      return AttendanceImageResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<AttendanceLogResponseModel> getAttendanceLogs(int month, int year,
      {String? status}) async {
    try {
      final response =
          await dio.get('/employee/attendance-log', queryParameters: {
        'month': month,
        'year': year,
        'status': status ?? '',
      });
      return AttendanceLogResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<CheckPlacementResponseModel> checkPlacementOffice(
      Map<String, dynamic> body) async {
    try {
      final response =
          await dio.post('/employee/attendance-check-location', data: body);
      return CheckPlacementResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<AttendanceDetailResponseModel> getAttendanceDetail(String date) async {
    try {
      final response = await dio.get('/employee/attendance-detail/$date');
      return AttendanceDetailResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ClockAcceptResponseModel> checkAcceptClock(
      Map<String, dynamic> body) async {
    try {
      final response =
          await dio.post('/employee/attendance-check-before-clock', data: body);
      return ClockAcceptResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<AttendanceResponseModel> clockAttendance(
      Map<String, dynamic> body) async {
    try {
      final response = await dio.post('/employee/attendance-clock', data: body);
      return AttendanceResponseModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ScheduleResponseModel> getSchedule(String date) async {
    try {
      final response = await dio.get('/employee/schedule', queryParameters: {
        'date': date,
      });
      return ScheduleResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<bool> checkAcceptClockAttendance(Map<String, dynamic> body) async {
    try {
      final response = await dio.post(
        '/employee/attendance-check-clocked',
        data: body,
      );
      if (response.data['data']['accepted'] != null &&
          response.data['data']['accepted'] == true) {
        return true;
      } else {
        throw DefaultApiException(message: response.data['data']['message']);
      }
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ScheduleResponseModel> getScheduleLog(
      String startDate, String endDate) async {
    try {
      final response = await dio.get(
        '/employee/schedule',
        queryParameters: {
          'date': startDate,
          'endDate': endDate,
          'per_page': 31,
        },
      );
      return ScheduleResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ClockButtonModel> getClockButtonType() async {
    try {
      final response = await dio.post('/employee/check-button-clockin');
      return ClockButtonModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<bool> syncAttendances(List<Map> data) async {
    try {
      final response =
          await dio.post('/employee/attendances/offline', data: data);
      return response.statusCode == 200;
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<UploadFilesResponseModel> uploadAttendanceImages(FormData data) async {
    try {
      final response = await dio.post('/employee/offline/files', data: data);

      return UploadFilesResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<bool> cancelAttendance() async {
    try {
      final response =
          await dio.post('/employee/attendances/cancel-attendance');

      return response.statusCode == 200;
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<BreakTimeResponseModel> breakTime(Map<String, dynamic> body) async {
    try {
      final response = await dio.post('/employee/attendance/break', data: body);
      return BreakTimeResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<bool> checkBreakTimeSetting() async {
    try {
      final response = await dio.get('/employee/attendance/break-setting');
      if (response.data['data']['is_can_close_page'] == true) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
