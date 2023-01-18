part of 'config.dart';

/// List all Flavors type
///
/// ## 1. Dev
///
/// This flavor use for testing API, for development mode, or when you running
/// in **debug** mode.
///
///---
///
/// ## 2. Staging
///
///---
///
/// ## 3. Prod
///
/// This flavor only for release mode in Store (Play Store || Apps Store)
enum Flavor {
  /// This flavor use for testing API, for development mode, or when you running
  /// in **debug** mode.
  // ignore: constant_identifier_names
  DEV,

  ///
  // ignore: constant_identifier_names
  STAGING,

  /// This flavor only for release mode in Store (Play Store || Apps Store)
  // ignore: constant_identifier_names
  PROD,
}

// ignore: avoid_classes_with_only_static_members
/// List all flavors config
///
///
class F {
  /// Flavor type
  static Flavor? flavor;
}
