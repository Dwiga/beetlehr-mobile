import 'dart:developer';
import 'dart:io';

import 'package:dependencies/dependencies.dart';

import '../../../settings.dart';

class PushNotificationService {
  final SaveTokenUseCase useCase;
  final _fcm = FirebaseMessaging.instance;

  PushNotificationService({required this.useCase});

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const _initializationSettingsAndroid =
      AndroidInitializationSettings('ic_stat_icon');

  static const _initializationSettingsIOS = IOSInitializationSettings();

  static const _notificationChannel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // name
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  static const _initializationSettings = InitializationSettings(
    android: _initializationSettingsAndroid,
    iOS: _initializationSettingsIOS,
  );

  Future initialize() async {
    if (Platform.isIOS) {
      _requestPermission();
    }
    _configure();
    _initializeLocalNotification();
    _listenToken();
  }

  void _requestPermission() async {
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void _configure() {
    FirebaseMessaging.onMessage.listen((message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      final notification = message.notification;
      final android = notification?.android;
      final ios = notification?.apple;

      if (notification != null) {
        if ((Platform.isAndroid && android != null) ||
            (Platform.isIOS && ios != null)) {
          _flutterLocalNotificationsPlugin.show(
            message.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: android != null
                  ? AndroidNotificationDetails(
                      _notificationChannel.id,
                      _notificationChannel.name,
                      channelDescription: _notificationChannel.description,
                      icon: android.smallIcon,
                    )
                  : null,
            ),
          );
        }
      }
    });
  }

  void _initializeLocalNotification() async {
    await _flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
      onSelectNotification: (payload) async {
        if (payload != null) {
          log('notification payload: $payload');
        }
      },
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_notificationChannel);
  }

  void _listenToken() async {
    FirebaseMessaging.instance.onTokenRefresh.listen(useCase);
  }
}
