import 'dart:developer';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/foundation.dart';

class RecordErrorUseCase implements UseCase<bool, RecordErrorParams> {
  final FirebaseCrashlytics firebaseCrashlytics;

  const RecordErrorUseCase(this.firebaseCrashlytics);

  @override
  Future<Either<Failure, bool>> call(RecordErrorParams params) async {
    try {
      if (!kDebugMode) {
        Sentry.captureException(
          params.exception,
          stackTrace: params.stackTrace,
          hint: params.errorMessage,
          withScope: (scope) {
            scope.level = params.level;
            if (params.tags != null) scope.fingerprint = params.tags!;

            if (params.attachments != null) {
              for (final item in params.attachments!) {
                scope.addAttachment(item);
              }
            }
          },
        );

        firebaseCrashlytics.recordError(
          params.exception,
          params.stackTrace is StackTrace
              ? params.stackTrace
              : StackTrace.fromString(params.stackTrace ?? ''),
          fatal: params.level == SentryLevel.fatal,
          printDetails: true,
          reason: params.errorMessage,
        );
      } else {
        log(
          params.exception.toString(),
          error: params.errorMessage ?? params.exception.toString(),
          stackTrace: params.stackTrace,
          name: 'ERROR',
        );
      }
    } catch (_) {}

    return const Right(true);
  }
}

class RecordErrorParams extends Equatable {
  final String? errorMessage;
  final Object? exception;
  final dynamic stackTrace;
  final SentryLevel level;
  final List<String>? tags;
  final List<SentryAttachment>? attachments;
  final String? library;

  const RecordErrorParams({
    this.errorMessage,
    this.exception,
    this.stackTrace,
    this.level = SentryLevel.warning,
    this.tags,
    this.attachments,
    this.library,
  });

  @override
  List<Object?> get props => [
        errorMessage,
        exception,
        stackTrace,
        level,
        tags,
        attachments,
        library,
      ];
}
