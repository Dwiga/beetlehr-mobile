import 'failures.dart';

/// Getting error from Internal Server Error
class InternalServerFailure extends Failure {
  /// Getting error from Internal Server Error
  const InternalServerFailure({
    required String message,
    int? code,
  }) : super(code: code, message: message);
}

/// Getting error from default error
class DefaultServerFailure extends Failure {
  /// Getting error from default response error
  const DefaultServerFailure({
    required String message,
    int? code,
  }) : super(code: code, message: message);
}

/// Getting error from Timeout get API
class TimeOutApiFailure extends Failure {
  /// Getting error from Timeout get API
  const TimeOutApiFailure({
    required String message,
    int? code,
  }) : super(code: code, message: message);
}

/// Getting error from API, when user unAuthenticated
class UnAuthenticatedApiFailure extends Failure {
  /// Getting error from API, when user unAuthenticated
  const UnAuthenticatedApiFailure({
    required String message,
    int? code,
  }) : super(code: code, message: message);
}

/// Getting error from API, when user don't have a access
class UnAuthorizeApiFailure extends Failure {
  /// Getting error from API, when user don't have a access
  const UnAuthorizeApiFailure({
    required String message,
    int? code,
  }) : super(code: code, message: message);
}
