import 'package:dependencies/dependencies.dart';

export 'cache_failure.dart';
export 'server_failure.dart';

/// Base class `Failure`
///
/// This class use, when your implements/creating a new handling Failure
///
/// For example create a [ServerFailure] to handle a failure from exception
abstract class Failure extends Equatable {
  /// Message failure from exceptions
  final String message;

  /// Failure code
  final int? code;

  /// Example:
  ///
  /// ```dart
  /// class ServerFailure extends Failure {
  ///   ServerFailure({
  ///     String message,
  ///     int code,
  ///   }): super(message: message, code: code);
  /// }
  /// ```
  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];

  @override
  bool get stringify => true;
}
