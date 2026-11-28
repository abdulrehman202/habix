// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Runs in a separate isolate when the app is in the background/terminated.
  // FCM shows "notification" payloads automatically, so usually nothing to do.
}

class NotificationService {
  NotificationService(this._dio);

  final Dio _dio;
  final _messaging = FirebaseMessaging.instance;
  final _local = FlutterLocalNotificationsPlugin();

  static const _channel = AndroidNotificationChannel(
    'habit_reminders',
    'Habit reminders',
    description: 'Reminders to complete your habits',
    importance: Importance.high,
  );

  Future<void> init({void Function(Map<String, dynamic> data)? onTap}) async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    // Local notifications setup
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _local.initialize(
      settings:   initSettings,
      onDidReceiveNotificationResponse: (resp) {
        // Tapped a local notification (foreground case)
        if (resp.payload != null && onTap != null) {
          onTap({'payload': resp.payload});
        }
      },
    );
    await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // Foreground: FCM doesn't display notifications by itself, so we do.
    FirebaseMessaging.onMessage.listen((message) {
      final n = message.notification;
      if (n == null) return;
      _local.show(
        id: n.hashCode,
        title: n.title,
        body: n.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data['habitId'],
      );
    });

    // App opened from background by tapping a notification
    FirebaseMessaging.onMessageOpenedApp.listen((m) => onTap?.call(m.data));

    // App opened from terminated state by tapping a notification
    final initial = await _messaging.getInitialMessage();
    if (initial != null) onTap?.call(initial.data);

    // Keep backend in sync if the token rotates
    _messaging.onTokenRefresh.listen(_sendTokenToBackend);

    
  }

  /// Call after the user logs in.
  Future<void> registerDevice() async {
    try{
    final token = await _messaging.getToken();
    if (token != null) await _sendTokenToBackend(token);
    }
    catch(_){}
  }

  /// Call on logout.
  Future<void> unregisterDevice() async {
    try{
    final token = await _messaging.getToken();
    if (token != null) {
      await _dio.delete('/devices', data: {'token': token});
    }
    await _messaging.deleteToken();}
    catch(_){}
  }

  Future<void> _sendTokenToBackend(String token) async {
    try {
      await _dio.post('/devices', data: {
        'token': token,
        'platform': Platform.isIOS ? 'ios' : 'android',
      });
    } catch (_) {
      // Retry later / log
    }
  }
}