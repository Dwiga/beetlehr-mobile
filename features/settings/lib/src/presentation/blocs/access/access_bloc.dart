import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dependencies/dependencies.dart';
import 'package:flutter/services.dart';
import 'package:settings/settings.dart';

part 'access_event.dart';
part 'access_state.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  AccessBloc() : super(AccessInitial());

  @override
  Stream<AccessState> mapEventToState(
    AccessEvent event,
  ) async* {
    if (event is StartCheckAccessEvent) {
      yield* _checkAccessToState();
    } else if (event is ChangeMockLocationAccessEvent) {
      if (event.isMockLocation == true && (state is! AccessUseMockLocation)) {
        yield AccessInitial();
        yield AccessUseMockLocation();
        GetIt.I<RecordErrorUseCase>()(RecordErrorParams(
          library: 'Geolocator',
          tags: const ['geolocator'],
          errorMessage: 'Device is now using mock location',
          level: SentryLevel.debug,
          stackTrace: StackTrace.current,
          exception: Exception('Device is now using mock location'),
        ));
      }
    }
  }

  Stream<AccessState> _checkAccessToState() async* {
    // --------------- ROOT CHECKER -------------
    try {
      final isRoot = await _checkRootAccess();
      if (isRoot == true) {
        yield AccessInitial();
        yield AccessUseRoot();
      }
    } on TimeoutException catch (_) {}
    // -------------------------------------------
  }

  Future<bool> _checkRootAccess() async {
    try {
      var isRooted = false;

      if (Platform.isIOS) {
        isRooted = await RootDetector.isRooted(busyBox: true);
      } else {
        isRooted = await RootDetector.isRooted();
      }

      if (isRooted) {
        GetIt.I<RecordErrorUseCase>()(RecordErrorParams(
          library: 'Root Detector',
          tags: const ['root_detector'],
          errorMessage: 'Device is rooted',
          level: SentryLevel.debug,
          stackTrace: StackTrace.current,
          exception: Exception('Device is rooted'),
        ));
      }

      return isRooted;
    } on PlatformException catch (_) {
      log('Error when check Root: ${_.message}');
      GetIt.I<RecordErrorUseCase>()(RecordErrorParams(
        library: 'Root Detector',
        tags: const ['root_detector'],
        errorMessage: 'Can\'t fetch status is Rooted',
        level: SentryLevel.debug,
        stackTrace: StackTrace.current,
        exception: Exception('Can\'t fetch status is Rooted'),
      ));

      return false;
    } catch (e) {
      log('ERROR: $e');
      return false;
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
