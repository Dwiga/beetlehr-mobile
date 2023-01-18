/// Error handling from a any process from API,
/// for example [TimeOutApiException]
/// [InternalServerException]
abstract class ServerException implements Exception {
  /// Getting message base from the catch
  final String message;

  /// Getting code error from the catch
  final int? code;

  ///
  const ServerException({
    required this.message,
    this.code,
  });

  @override
  String toString() {
    return 'ServerException{message: $message, code: $code}';
  }
}

/// Handling error base from basic error from response API, for example
/// Bad request,
class DefaultApiException extends ServerException {
  ///
  const DefaultApiException({
    required String message,
    int? code,
  }) : super(
          code: code,
          message: message,
        );

  @override
  String toString() {
    return 'DefaultApiException{message: $message, code: $code}';
  }
}

/// Handling error base from timeout get a API, or network
class TimeoutApiException extends ServerException {
  ///
  const TimeoutApiException({
    int? code,
  }) : super(
          code: code,
          message: '',
        );

  @override
  String toString() {
    return 'TimeoutApiException{code: $code}';
  }
}

/// Handling error from API, when server response error code 500 or higher,
/// This exceptions handle to detect when intenal server is fail
class InternalServerException extends ServerException {
  /// In field [message] to custom a message when server is fail
  /// And the [code] field error code, for example `500 (Internal Server Error)`
  const InternalServerException({
    required String message,
    int? code,
  }) : super(
          message: message,
          code: code,
        );

  @override
  String toString() {
    return 'InternalServerException{message: $message, code: $code}';
  }
}

/// Handling error from API, when user don't have access,
/// because user not have a token, or session auth(Login/Register)
class UnAuthenticatedApiException extends ServerException {
  /// In field [message] to custom a message when user not have access
  /// And the [code] field error code
  const UnAuthenticatedApiException({
    required String message,
    int? code,
  }) : super(
          message: message,
          code: code,
        );

  @override
  String toString() {
    return 'UnAuthenticatedApiException{message: $message, code: $code}';
  }
}

/// Handling error from API, when user don't have access,
/// because user not have access a endpoint API,
/// for example, user access to other user tracsaction,
/// Or access a data admin
class UnAuthorizeApiException extends ServerException {
  /// In field [message] to custom a message when fail
  /// And the [code] field error code
  const UnAuthorizeApiException({
    required String message,
    int? code,
  }) : super(
          message: message,
          code: code,
        );

  @override
  String toString() {
    return 'UnAuthorizeApiException{message: $message, code: $code}';
  }
}
