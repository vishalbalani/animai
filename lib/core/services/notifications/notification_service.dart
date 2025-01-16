import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract interface class NotificationServices {
  Future<void> requestNotificationPermission();

  Future<void> initLocalNotifications();

  Future<int> showNotification({
    required String title,
    required String body,
  });

  Future<void> cancelNotification(int id);
}

class NotificationServicesImpl implements NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  const NotificationServicesImpl(this.flutterLocalNotificationsPlugin);

  // Request permission to show notifications
  @override
  Future<void> requestNotificationPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            'subscription',
            'Subscription',
            importance: Importance.high,
          ),
        );
  }

  // Initialize local notifications
  @override
  Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_notification');
    const iosInitializationSettings = DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );

    await requestNotificationPermission();
  }

  @override
  Future<int> showNotification({
    required String title,
    required String body,
  }) async {
    final id = Random().nextInt(9999999);

    // Remove the icon parameter since we'll use the default app icon
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'subscription',
      'Subscription',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@drawable/ic_notification',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: '',
    );
    return id;
  }

  @override
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
