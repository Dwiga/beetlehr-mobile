import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

/// Observing Bloc State Management
/// This class show logging when Bloc trigger
/// `onEvent`, `onTransition State`, `onError`
///
/// This class can be handle all blocs state mangement
///
/// **When** : Error, new Event, Transition State of a Bloc
///
/// To use this Bloc Observer, this code full example:
///
/// Paste this code in void `main()`, usually void main in `lib/main.dart`
///
/// ```dart
/// void main() {
/// ...
///   WidgetsFlutterBinding.ensureInitialized();
///   Bloc.observer = AppBlocObserver();
/// ...
/// }
/// ```
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    _printDebug('Bloc: ${bloc.runtimeType}, Event: ${event.runtimeType}');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _printDebug('Bloc: ${bloc.runtimeType}, Error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    _printDebug('Bloc: ${bloc.runtimeType} , Transition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    _printDebug('Close Bloc/Cubit: ${bloc.runtimeType}');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    _printDebug('Create Bloc/Cubit: ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  void _printDebug(String v) {
    if (kDebugMode) {
      log(v);
    }
  }
}
