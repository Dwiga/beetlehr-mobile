import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../data.dart';

abstract class ProfileApiDataSource {
  Future<ProfileResponseModel> getProfile();

  Future<ProfileResponseModel> updateProfile(FormData body);
}

class ProfileApiDataSourceImpl implements ProfileApiDataSource {
  final Dio dio;

  ProfileApiDataSourceImpl(this.dio);

  @override
  Future<ProfileResponseModel> getProfile() async {
    try {
      final response = await dio.get('/employee/profile');

      return ProfileResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<ProfileResponseModel> updateProfile(FormData body) async {
    try {
      final response = await dio.post('/employee/profile/update', data: body);

      return ProfileResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
