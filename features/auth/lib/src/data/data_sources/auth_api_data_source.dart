import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../models/auth_response_model.dart';

/// Auth Api Data Source
///
/// Handling all data by authentication
///
/// For example: Login, Register, Reset Password
abstract class AuthApiDataSource {
  /// Login user with Email
  /// Param [jsonBody] must type [Map<String, dynamic>] and must not null
  Future<AuthResponseModel> loginWithEmail(Map<String, dynamic> jsonBody);

  /// Reset Password from user login with Email
  /// Params [email] must be valid email
  Future<bool> resetPasswordEmail(String email);
}

/// Implementation of class interface/abstract [AuthApiDataSource]
class AuthApiDataSourceImpl implements AuthApiDataSource {
  /// Dio for HttpClient
  final Dio dio;

  /// Param dio must not be null
  AuthApiDataSourceImpl(this.dio);

  @override
  Future<AuthResponseModel> loginWithEmail(
      Map<String, dynamic> jsonBody) async {
    try {
      final response =
          await dio.post('/employee/authentication/login', data: jsonBody);
      return AuthResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<bool> resetPasswordEmail(String email) async {
    try {
      final _dioWithOption = dio..options.headers['ignore_403'] = true;
      final response = await _dioWithOption.post(
        '/employee/authentication/password/email',
        data: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
