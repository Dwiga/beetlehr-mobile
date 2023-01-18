import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:background_locator/settings/network_settings.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'auto_stop_handler.dart';
import 'callback_dispatcher.dart';
import 'keys.dart';
import 'settings/android_settings.dart';
import 'settings/ios_settings.dart';
import 'utils/settings_util.dart';

export 'settings/android_settings.dart';
export 'settings/ios_settings.dart';
export 'settings/locator_settings.dart';
export 'settings/network_settings.dart';

class BackgroundLocator {
  static const MethodChannel _channel = const MethodChannel(Keys.CHANNEL_ID);

  static Future<void> initialize() async {
    final CallbackHandle callback =
        PluginUtilities.getCallbackHandle(callbackDispatcher)!;
    await _channel.invokeMethod(Keys.METHOD_PLUGIN_INITIALIZE_SERVICE,
        {Keys.ARG_CALLBACK_DISPATCHER: callback.toRawHandle()});
  }

  static Future<void> registerLocationUpdate({
    void Function(Map<String, dynamic>)? initCallback,
    Map<String, dynamic> initDataCallback = const {},
    void Function()? disposeCallback,
    bool autoStop = false,
    AndroidSettings androidSettings = const AndroidSettings(),
    IOSSettings iosSettings = const IOSSettings(),
    NetworkSettings? networkSettings,
  }) async {
    if (autoStop) {
      WidgetsBinding.instance!.addObserver(AutoStopHandler());
    }

    final args = SettingsUtil.getArgumentsMap(
      initCallback: initCallback,
      initDataCallback: initDataCallback,
      disposeCallback: disposeCallback,
      androidSettings: androidSettings,
      iosSettings: iosSettings,
      networkSettings: networkSettings,
    );

    await _channel.invokeMethod(
        Keys.METHOD_PLUGIN_REGISTER_LOCATION_UPDATE, args);
  }

  static Future<void> unRegisterLocationUpdate() async {
    await _channel.invokeMethod(Keys.METHOD_PLUGIN_UN_REGISTER_LOCATION_UPDATE);
  }

  static Future<bool> isRegisterLocationUpdate() async {
    return (await _channel
        .invokeMethod<bool>(Keys.METHOD_PLUGIN_IS_REGISTER_LOCATION_UPDATE))!;
  }

  static Future<bool> isServiceRunning() async {
    return (await _channel
            .invokeMethod<bool>(Keys.METHOD_PLUGIN_IS_SERVICE_RUNNING)) ??
        false;
  }

  static Future<bool> checkAvailableSupportBackgroundPermission() async {
    final result = await _channel
        .invokeMethod<bool>(Keys.METHOD_PLUGIN_AVAILABLE_BACKGROUND_PERMISSION);
    return result ?? false;
  }

  static Future<bool> updateBackgroundPermission() async {
    if (Platform.isAndroid) {
      return (await _channel.invokeMethod<bool>(
              Keys.METHOD_PLUGIN_UPDATE_BACKGROUND_PERMISSION)) ??
          false;
    }

    return true;
  }

  static Future<void> updateNotificationText(
      {String? title, String? msg, String? bigMsg}) async {
    final Map<String, dynamic> arg = {};

    if (title != null) {
      arg[Keys.SETTINGS_ANDROID_NOTIFICATION_TITLE] = title;
    }

    if (msg != null) {
      arg[Keys.SETTINGS_ANDROID_NOTIFICATION_MSG] = msg;
    }

    if (bigMsg != null) {
      arg[Keys.SETTINGS_ANDROID_NOTIFICATION_BIG_MSG] = bigMsg;
    }

    await _channel.invokeMethod(Keys.METHOD_PLUGIN_UPDATE_NOTIFICATION, arg);
  }
}
