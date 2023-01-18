import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

/// Module base should implemented
///
/// Must implement :
///
/// - Dependency Injection
/// - Routing
///
abstract class BaseModule {
  /// Make routes from your module
  ///
  /// Example use:
  ///
  /// ```dart
  /// {
  ///   '/home': MaterialPageRoute(builder: (_) => HomePage()),
  ///   '/login': CupertinoPageRoute(builder: (_) => LoginPage()),
  /// ]
  /// ```
  Map<String, Route> routes(RouteSettings settings);

  /// Inject all source
  ///
  /// - Singleton
  /// - Factory
  void inject(GetIt getIt);
}
