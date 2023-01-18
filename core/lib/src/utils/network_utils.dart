import 'package:dependencies/dependencies.dart';
import 'package:l10n/l10n.dart';

import '../../core.dart';

// ignore: avoid_classes_with_only_static_members
/// Basic utils to handle network
class NetworkUtils {
  ///
  static final List<int> _supportedErrorStatusCode =
      List.generate(100, (index) => 400 + index);

  /// Returning exception base from error Http Client DIO
  static Future<ServerException> dioErrorToException(DioError err) async {
    final meta = err.response?.data is Map && err.response?.data['meta'] is Map
        ? MetaData.fromJson(err.response?.data['meta'] ?? {})
        : null;

    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.receiveTimeout ||
        err.type == DioErrorType.sendTimeout) {
      return await _checkHaveInternetConnectionToException();
    } else if (err.type == DioErrorType.response) {
      if (err.response?.statusCode == 401) {
        return UnAuthenticatedApiException(
          code: 401,
          message: meta?.message ?? '',
        );
      } else if (err.response?.statusCode == 403) {
        return UnAuthorizeApiException(
          code: 403,
          message: meta?.message ?? '',
        );
      } else if ((err.response?.statusCode ?? 0) >= 500) {
        return InternalServerException(
          code: err.response?.statusCode,
          message: meta?.message ?? '',
        );
      } else if (_supportedErrorStatusCode
          .contains(err.response?.statusCode ?? 0)) {
        return DefaultApiException(
          code: err.response?.statusCode,
          message: meta?.message ?? '',
        );
      }
      return await _checkHaveInternetConnectionToException();
    } else {
      if (err.response == null) {
        return await _checkHaveInternetConnectionToException();
      }
      return DefaultApiException(
        code: err.response?.statusCode,
        message: meta?.message ?? '',
      );
    }
  }

  static Future<ServerException>
      _checkHaveInternetConnectionToException() async {
    try {
      return const TimeoutApiException();
    } catch (e) {
      return const TimeoutApiException();
    }
  }

  /// From [ServerException] to [ServerFailure]
  static Failure? serverExceptionToFailure(ServerException exception) {
    if (exception is DefaultApiException) {
      return DefaultServerFailure(
        code: exception.code,
        message: exception.message,
      );
    } else if (exception is InternalServerException) {
      return InternalServerFailure(message: S.current.message_server_busy);
    } else if (exception is TimeoutApiException) {
      return TimeOutApiFailure(message: S.current.message_time_out);
    } else if (exception is UnAuthenticatedApiException) {
      return UnAuthenticatedApiFailure(
        code: exception.code,
        message: exception.message,
      );
    } else if (exception is UnAuthorizeApiException) {
      return UnAuthorizeApiFailure(
        code: exception.code,
        message: exception.message,
      );
    }
    return null;
  }
}
