import 'dart:io';
import 'dart:ui';

import '../settings/network_settings.dart';
import '../keys.dart';
import '../settings/android_settings.dart';
import '../settings/ios_settings.dart';

class SettingsUtil {
  static Map<String, dynamic> getArgumentsMap({
    void Function(Map<String, dynamic>)? initCallback,
    Map<String, dynamic>? initDataCallback,
    void Function()? disposeCallback,
    AndroidSettings androidSettings = const AndroidSettings(),
    IOSSettings iosSettings = const IOSSettings(),
    NetworkSettings? networkSettings,
  }) {
    final args = _getCommonArgumentsMap(
      initCallback: initCallback,
      initDataCallback: initDataCallback,
      disposeCallback: disposeCallback,
    );

    if (Platform.isAndroid) {
      args.addAll(_getAndroidArgumentsMap(androidSettings));
    } else if (Platform.isIOS) {
      args.addAll(_getIOSArgumentsMap(iosSettings));
    }

    if (networkSettings != null) {
      final entries = _getNetworkArgumentsMap(networkSettings);

      args.addAll(entries);
    }

    return args;
  }

  static Map<String, dynamic> _getCommonArgumentsMap({
    void Function(Map<String, dynamic>)? initCallback,
    Map<String, dynamic>? initDataCallback,
    void Function()? disposeCallback,
  }) {
    final Map<String, dynamic> args = {};

    if (initCallback != null) {
      args[Keys.ARG_INIT_CALLBACK] =
          PluginUtilities.getCallbackHandle(initCallback)!.toRawHandle();
    }
    if (disposeCallback != null) {
      args[Keys.ARG_DISPOSE_CALLBACK] =
          PluginUtilities.getCallbackHandle(disposeCallback)!.toRawHandle();
    }
    if (initDataCallback != null) {
      args[Keys.ARG_INIT_DATA_CALLBACK] = initDataCallback;
    }

    return args;
  }

  static Map<String, dynamic> _getAndroidArgumentsMap(
      AndroidSettings androidSettings) {
    final Map<String, dynamic> args = androidSettings.toMap();

    if (androidSettings.androidNotificationSettings.notificationTapCallback !=
        null) {
      args[Keys.ARG_NOTIFICATION_CALLBACK] = PluginUtilities.getCallbackHandle(
              androidSettings
                  .androidNotificationSettings.notificationTapCallback!)!
          .toRawHandle();
    }

    return args;
  }

  static Map<String, dynamic> _getIOSArgumentsMap(IOSSettings iosSettings) {
    return iosSettings.toMap();
  }

  static Map<String, dynamic> _getNetworkArgumentsMap(
      NetworkSettings networkSettings) {
    return networkSettings.toMap();
  }
}
