import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../data.dart';

abstract class ResignApiDataSource {
  Future<ResignResponseModel> createResign(FormData body);

  Future<ResignResponseModel> getResign();

  Future<bool> cancelResign(int id);
}

class ResignApiDataSourceImpl implements ResignApiDataSource {
  final Dio dio;

  ResignApiDataSourceImpl(this.dio);

  @override
  Future<ResignResponseModel> createResign(FormData body) async {
    try {
      final response = await dio.post('/employee/resign', data: body);

      return ResignResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ResignResponseModel> getResign() async {
    try {
      final response = await dio.get('/employee/resign');

      return ResignResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<bool> cancelResign(int id) async {
    try {
      await dio.put('/employee/resign/$id/cancel');

      return true;
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
