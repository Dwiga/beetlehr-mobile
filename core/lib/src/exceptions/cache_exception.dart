/// Handling error from a local data source, for example a SQLite, SharedPref,
/// etc...
///
class CacheException implements Exception {
  /// Error message when fail
  final String message;

  /// Error code
  final int? code;

  ///
  const CacheException({
    required this.message,
    this.code,
  });

  @override
  String toString() {
    return 'CacheException{message: $message, code: $code}';
  }
}

/// Handling cache when cache is null, or cache not found
class NotFoundCacheException extends CacheException {
  ///
  const NotFoundCacheException({
    required String message,
    int? code,
  }) : super(message: message);

  @override
  String toString() {
    return 'NotFoundCacheException{message: $message, code: $code}';
  }
}
