// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/extensions/extension_string.dart';
import '../utils/general_data.dart';
import 'service_route.dart';

class ServiceNotification {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'oto_gallery_channel',
    'Oto Galeri High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );
  static var notification = FlutterLocalNotificationsPlugin();

  static Future<void> configure() async {
    await notification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    const android = AndroidInitializationSettings('mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const initPlatform = InitializationSettings(android: android, iOS: iOS);
    await notification.initialize(
      initPlatform,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    await FirebaseMessaging.instance.subscribeToTopic('oto_gallery_otomas');

    await FirebaseMessaging.instance.requestPermission();

    if (GeneralData.getInstance().getFCMToken() == null) {
      final token = (await FirebaseMessaging.instance.getToken()) ?? '';
      await GeneralData.getInstance().setFCMToken(token);
      await GeneralData.getInstance().setIsChangedFCMToken(true);
      log(token, name: 'FCM Token is changed');
    } else {
      log(GeneralData.getInstance().getFCMToken().toString(), name: 'FCM Token');
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      GeneralData.getInstance().setFCMToken(token);
      GeneralData.getInstance().setIsChangedFCMToken(true);
      log(token, name: 'FCM Token is changed');
    });

    FirebaseMessaging.onMessage.listen(showNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      openDetail(message.data['Link'], false);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      openDetail(initialMessage.data['Link'], true);
    }
  }

  static Future<void> onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      openDetail(payload, false);
    }
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse notificationResponse) {
    final payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      openDetail(payload, true);
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    openDetail(message.data['Link'], false);
  }

  static void showNotification(RemoteMessage message) {
    final remoteNotification = message.notification;
    final android = remoteNotification?.android;
    if (remoteNotification != null && android != null) {
      unawaited(
        notification.show(
          remoteNotification.hashCode,
          remoteNotification.title,
          remoteNotification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
            ),
          ),
          payload: message.data['Link'],
        ),
      );
    }
  }

  static void openDetail(String? payload, bool isBackground) {
    if (payload != null) {
      if (isBackground) {
        GeneralData.getInstance().notificationLink = payload;
      } else {
        if (GeneralData.getInstance().getAuthToken().isNullOrEmpty() || Jwt.isExpired(GeneralData.getInstance().getAuthToken()!)) {
          if (ServiceRoute.rootRouter.current.name != 'login') {
            // ServiceRoute.rootRouter.replaceAll([RouteLogin()]);
          }
          GeneralData.getInstance().notificationLink = payload;
        } else {
          unawaited(ServiceRoute.rootRouter.pushNamed(payload));
        }
      }
    }
  }
}
