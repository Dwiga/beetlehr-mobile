import 'dart:async';

import 'package:flutter/services.dart';

class FlutterDeviceId {
  static const MethodChannel _channel =
      const MethodChannel('id.flutter/flutter_device_id');

  FlutterDeviceId();

  String? _cacheId;

  Future<String?> get deviceId async {
    if (_cacheId != null && (_cacheId ?? '').isNotEmpty) {
      return _cacheId;
    }

    final String version = await _channel.invokeMethod('getDeviceId');
    _cacheId = version;
    return version;
  }
}
