import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../data.dart';

abstract class LeaveApiDataSource {
  Future<LeaveResponseModel> getLeaves(
      {required bool isComplete, required int page, required int perPage});

  Future<LeaveDetailResponseModel> getDetailLeave(int id);

  Future<LeaveTypeResponseModel> getLeaveType(
      {required int page, required int perPage});

  Future<bool> createLeave(FormData body);

  Future<bool> cancelLeave(int id);
}

class LeaveApiDataSourceImpl implements LeaveApiDataSource {
  final Dio dio;

  LeaveApiDataSourceImpl(this.dio);

  @override
  Future<LeaveResponseModel> getLeaves(
      {required bool isComplete,
      required int page,
      required int perPage}) async {
    try {
      final response = await dio.get('/employee/leave', queryParameters: {
        'page': page,
        'per_page': perPage,
        'type': isComplete == true ? 'complete' : 'inprocess',
      });

      return LeaveResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<LeaveDetailResponseModel> getDetailLeave(int id) async {
    try {
      final response = await dio.get('/employee/leave/$id');

      return LeaveDetailResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<LeaveTypeResponseModel> getLeaveType(
      {required int page, required int perPage}) async {
    try {
      final response = await dio.get('/employee/leave-type', queryParameters: {
        'page': page,
        'per_page': perPage,
      });

      return LeaveTypeResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<bool> createLeave(FormData body) async {
    try {
      await dio.post('/employee/leave', data: body);

      return true;
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<bool> cancelLeave(int id) async {
    try {
      await dio.put('/employee/leave/$id/cancel');

      return true;
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
