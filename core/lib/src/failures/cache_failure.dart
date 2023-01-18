import 'failures.dart';

/// Get error data from cache
class CacheFailure extends Failure {
  ///
  const CacheFailure({
    required String message,
    int? code,
  }) : super(
          code: code,
          message: message,
        );
}

class NotFoundCacheFailure extends CacheFailure {
  const NotFoundCacheFailure({
    required String message,
    int? code,
  }) : super(message: message, code: code);
}
