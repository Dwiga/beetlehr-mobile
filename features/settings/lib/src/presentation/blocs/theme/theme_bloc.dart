import 'dart:async';

import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../../settings.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// State management for dynamic theme
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  /// Theme Repository
  final ThemeRepository repository;

  ///
  ThemeBloc({required this.repository})
      : super(
          ThemeState(
            theme: AppThemeData.datas[AppTheme.blueLight]!,
          ),
        );

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ChangeThemeEvent) {
      yield ThemeState(theme: AppThemeData.datas[event.theme] ?? state.theme);
    }
  }
}
