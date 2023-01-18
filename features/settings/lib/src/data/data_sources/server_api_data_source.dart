import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:settings/settings.dart';

abstract class ServerApiDataSource {
  Future<CheckServerModel> getServerStatus(
      String endpoint, BaseUrlSchema schema);
}

class ServerApiDataSourceImpl implements ServerApiDataSource {
  final Dio dio;

  ServerApiDataSourceImpl(this.dio);

  @override
  Future<CheckServerModel> getServerStatus(
      String endpoint, BaseUrlSchema schema) async {
    try {
      final response = await dio.get('/server/status', queryParameters: {
        'endpoint': endpoint,
        'protocol': schema.toUrlSchema()
      });
      return CheckServerModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
