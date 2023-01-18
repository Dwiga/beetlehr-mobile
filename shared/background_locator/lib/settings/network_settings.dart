import 'dart:convert';

import 'package:background_locator/keys.dart';

import 'locator_settings.dart';

class NetworkSettings extends LocatorSettings {
  /// The URL used to upload the latest location data
  final String url;

  /// HTTP method to upload the latest location data
  /// By default method is `POST`
  final NetworkSettingMethod method;

  /// HTTP method to upload the latest location data
  final Map<String, dynamic> headers;

  const NetworkSettings({
    LocationAccuracy accuracy = LocationAccuracy.NAVIGATION,
    double distanceFilter = 0,
    required this.url,
    this.method = NetworkSettingMethod.POST,
    this.headers = const {},
  }) : super(accuracy: accuracy, distanceFilter: distanceFilter); //minutes

  Map<String, dynamic> toMap() {
    return {
      Keys.SETTINGS_ACCURACY: accuracy.value,
      Keys.SETTINGS_DISTANCE_FILTER: distanceFilter,
      Keys.SETTINGS_NETWORK_URL: url,
      Keys.SETTINGS_NETWORK_METHOD: method.toText(),
      Keys.SETTINGS_NETWORKS_HEADERS: json.encode(headers),
    };
  }
}

enum NetworkSettingMethod { POST, PUT }

extension NetworkSettingMethodX on NetworkSettingMethod {
  String toText() {
    switch (this) {
      case NetworkSettingMethod.POST:
        return 'POST';
      case NetworkSettingMethod.PUT:
        return 'PUT';
    }
  }
}
