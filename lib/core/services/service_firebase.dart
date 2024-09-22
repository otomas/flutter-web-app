import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '/core/services/service_device_info.dart';
import '/core/utils/flavor_config.dart';
import '/core/utils/general_data.dart';
import '../constants/remote_config_keys.dart';
import '../enums/enum_app.dart';

class ServiceFirebase extends ChangeNotifier {
  ServiceFirebase(this.serviceDeviceInfo) {
    unawaited(initialize());

    mParameters.addAll({
      'userId': GeneralData.getInstance().getTokenData()?.id,
      'authToken': GeneralData.getInstance().getAuthToken().toString(),
      'fcmToken': GeneralData.getInstance().getFCMToken().toString(),
      'username': GeneralData.getInstance().getUsername().toString(),
      'platform': kIsWeb
          ? 'Web'
          : Platform.isIOS
              ? 'iOS'
              : 'Android',
      'model': kIsWeb
          ? 'Web'
          : Platform.isIOS
              ? serviceDeviceInfo.iosInfo?.model
              : '${serviceDeviceInfo.androidInfo?.model} + ${serviceDeviceInfo.androidInfo?.brand}',
      'systemName': kIsWeb
          ? 'Web'
          : Platform.isIOS
              ? serviceDeviceInfo.iosInfo?.systemName
              : serviceDeviceInfo.androidInfo?.device,
      'systemVersion': kIsWeb
          ? 'Web'
          : Platform.isIOS
              ? serviceDeviceInfo.iosInfo?.systemVersion
              : serviceDeviceInfo.androidInfo?.version,
      'nameOrHardware': kIsWeb
          ? 'Web'
          : Platform.isIOS
              ? serviceDeviceInfo.iosInfo?.name
              : serviceDeviceInfo.androidInfo?.hardware,
      'deviceId': kIsWeb
          ? 'Web'
          : Platform.isIOS
              ? serviceDeviceInfo.iosInfo?.identifierForVendor
              : serviceDeviceInfo.androidInfo?.id,
    });
  }
  late FirebaseAnalytics analytics;
  late FirebaseCrashlytics crashlytics;
  late FirebaseRemoteConfig remoteConfig;
  final ServiceDeviceInfo serviceDeviceInfo;

  Map<String, dynamic> mParameters = {};

  bool get isProd => FlavorConfig.instance.flavorName == Flavor.prod.value;

  Future<void> initialize() async {
    analytics = FirebaseAnalytics.instance;
    crashlytics = FirebaseCrashlytics.instance;
    remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.ensureInitialized();
    await remoteConfig.activate();
    await remoteConfig.fetch();
  }

  Future<void> setUserId(String userId) async {
    await analytics.setUserId(id: userId);
    await crashlytics.setUserIdentifier(userId);

    if (isProd) {
      await analytics.setAnalyticsCollectionEnabled(true);
      await crashlytics.setCrashlyticsCollectionEnabled(true);
    } else {
      await analytics.setAnalyticsCollectionEnabled(false);
      await crashlytics.setCrashlyticsCollectionEnabled(false);
    }
  }

  Future<void> logEvent(String name, [Map<String, dynamic>? parameters]) async {
    if (isProd && !kIsWeb) {
      parameters?.addAll(mParameters);
      await analytics.logEvent(
        name: name,
        parameters: parameters as Map<String, Object>,
      );
    }
  }

  Future<void> recordError({Map<String, dynamic>? parameters, StackTrace? stackTrace, String? reason, bool fatal = true}) async {
    if (isProd && !kIsWeb) {
      parameters?.addAll(mParameters);
      await crashlytics.recordError(
        parameters,
        stackTrace,
        reason: reason,
        fatal: fatal,
      );
    }
  }

  Future<bool> getIsActiveApp() async => remoteConfig.getBool(kIsWeb
      ? keyIsActiveWebApp
      : Platform.isAndroid
          ? keyIsActiveAndroidApp
          : keyIsActiveIOSApp,);

  Future<int> getVersionCode() async => kIsWeb ? double.maxFinite.toInt() : remoteConfig.getInt(Platform.isAndroid ? keyAndroidVersionCode : keyIOSVersionCode);
  Future<bool> getIsUpdateRequired() async => !kIsWeb && remoteConfig.getBool(Platform.isAndroid ? keyAndroidIsUpdateRequired : keyIOSIsUpdateRequired);
}
