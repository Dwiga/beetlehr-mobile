import 'dart:async';
import 'dart:io';

import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:settings/settings.dart';

import 'app/app.dart';

void runAppWithRecordError() {
  FlutterError.onError = (details) {
    if (details.exception is! SocketException &&
        details.exception is! FirebaseException) {
      GetIt.I<RecordErrorUseCase>().call(
        RecordErrorParams(
          exception: details.exception is Exception
              ? details.exception as Exception
              : null,
          level: SentryLevel.info,
          tags: const ['unhandle-error', 'flutter-error'],
          stackTrace: details.stack,
        ),
      );
    }
  };

  const app = App();
  runZonedGuarded(
    () => runApp(app),
    (exception, stackTrace) {
      GetIt.I<RecordErrorUseCase>().call(
        RecordErrorParams(
          exception: exception is Exception ? exception : null,
          level: SentryLevel.info,
          tags: const ['unhandle-error', 'flutter-error'],
          stackTrace: stackTrace,
        ),
      );
    },
  );
}
