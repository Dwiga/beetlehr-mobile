import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../payroll.dart';

// ignore: one_member_abstracts
abstract class PayrollApiDataSource {
  Future<PayrollResponseModel> getPayrolls({
    required int? month,
    required int? year,
    required int page,
    required int perPage,
  });

  Future<PayrollDetailResponse> getDetailPayroll(int id);

  Future<PayrollResponseModel> getPayrollsTHR(
      {required int page, required int perPage});

  Future<PayrollDetailResponse> getDetailPayrollTHR(int id);
}

class PayrollApiDataSourceImpl implements PayrollApiDataSource {
  final Dio dio;

  PayrollApiDataSourceImpl(this.dio);

  @override
  Future<PayrollResponseModel> getPayrolls(
      {required int? month,
      required int? year,
      required int page,
      required int perPage}) async {
    try {
      final response = await dio.get('/employee/payroll', queryParameters: {
        'month': month,
        'year': year,
        'page': page,
        'per_page': perPage,
      });

      return PayrollResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<PayrollDetailResponse> getDetailPayroll(int id) async {
    try {
      final response = await dio.get('/employee/payroll/$id');

      return PayrollDetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<PayrollResponseModel> getPayrollsTHR(
      {required int page, required int perPage}) async {
    try {
      final response = await dio.get('/employee/thr', queryParameters: {
        'page': page,
        'per_page': perPage,
      });

      return PayrollResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<PayrollDetailResponse> getDetailPayrollTHR(int id) async {
    try {
      final response = await dio.get('/employee/thr/$id');

      return PayrollDetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
