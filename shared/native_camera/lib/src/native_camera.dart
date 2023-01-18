import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_camera/native_camera.dart';
import 'package:native_camera/src/camera_page.dart';
import 'package:path_provider/path_provider.dart';

import 'camera_params.dart';

class NativeCamera {
  static const MethodChannel _channel =
      const MethodChannel('space.wisnuwiry/native_camera');

  static Future<File?> takePhoto(
      BuildContext context, CameraParams params) async {
    if (Platform.isAndroid) {
      final data = await _channel.invokeMethod('takePhoto', params.toMap());

      if (data != null && data is String) {
        final path = (await getApplicationDocumentsDirectory()).path +
            '/${DateTime.now().microsecondsSinceEpoch}.jpg';

        return await File(data).copy(path);
      }
    } else {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => CameraPage()),
      );

      if (result is File) {
        return result;
      }
    }

    return null;
  }
}
