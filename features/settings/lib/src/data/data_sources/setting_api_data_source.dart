import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

// ignore: one_member_abstracts
abstract class SettingApiDataSource {
  Future<bool> saveToken(String token);
}

class SettingApiDataSourceImpl implements SettingApiDataSource {
  final Dio dio;

  SettingApiDataSourceImpl(this.dio);

  @override
  Future<bool> saveToken(String token) async {
    try {
      final response = await dio.put('/employee/fcm-token/', data: {
        'fcm_token': token,
      });

      if (response.data['fcm_token'] != null) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
