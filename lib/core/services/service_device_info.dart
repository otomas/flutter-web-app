import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '/core/utils/general_data.dart';
import '../utils/utilities.dart';

class ServiceDeviceInfo extends ChangeNotifier {
  ServiceDeviceInfo() {
    unawaited(initialize());
  }
  late String deviceId;

  String ipAddress = '';
  String macAddress = '';

  String playStoreId = '';
  String appStoreId = '';

  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;

  String packageName = '';
  String version = '';
  int buildNumber = 0;

  late GooglePlayServicesAvailability availability;

  Future<void> initialize() async {
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        availability = await GoogleApiAvailability.instance.checkGooglePlayServicesAvailability();
      }

      deviceId = await GeneralData.getInstance().getDeviceId();
      log(deviceId, name: 'Device Id');
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
      } else {
        iosInfo = await deviceInfo.iosInfo;
      }

      final packageInfo = await PackageInfo.fromPlatform();
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = int.parse(packageInfo.buildNumber);
      log(version, name: Platform.isIOS ? 'iOS Version' : 'Android Version');
      log(buildNumber.toString(), name: 'Build Number');

      ipAddress = await printIps();
      // macAddress = await GetMacAddress().getMacAddress() ?? '';

      log(ipAddress, name: 'Ip Address');
      log(macAddress, name: 'Mac Address');
    }
  }
}
