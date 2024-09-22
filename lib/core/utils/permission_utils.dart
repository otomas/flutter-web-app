import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../enums/enum_app.dart';
import '../models/model_alert_dialog.dart';
import '../resources/_r.dart';
import '../services/service_device_info.dart';
import 'alert_utils.dart';

Future<bool> accessStoragePermission(BuildContext context) async {
  if (kIsWeb) {
    return true;
  }
  if (Platform.isAndroid) {
    const permission = PermissionStatus.granted;
    return !permission.isDenied;
  } else {
    final permission = await Permission.storage.request();
    if (permission.isDenied && context.mounted) {
      unawaited(showPlatformAlert(context, ModelAlertDialog(description: R.string.accessStoragePermission, dialogType: DialogTypes.error)));
    }
    return !permission.isDenied;
  }
}

Future<bool> accessCameraPermission(BuildContext context) async {
  if (kIsWeb) {
    return true;
  }
  final permission = await Permission.camera.request();
  if (permission.isDenied && context.mounted) {
    unawaited(showPlatformAlert(context, ModelAlertDialog(description: R.string.accessCameraPermission, dialogType: DialogTypes.error)));
  }
  return !permission.isDenied;
}

Future<bool> accessGalleryPermission(BuildContext context) async {
  if (kIsWeb) {
    return true;
  }
  if (Platform.isAndroid) {
    final sdkInt = Provider.of<ServiceDeviceInfo>(context, listen: false).androidInfo!.version.sdkInt;
    late PermissionStatus permission;
    if (context.mounted) {
      permission = (Platform.isAndroid && sdkInt >= 33) ? PermissionStatus.granted : await Permission.storage.request();
      if (permission.isDenied && context.mounted) {
        unawaited(showPlatformAlert(context, ModelAlertDialog(description: R.string.accessGalleryPermission, dialogType: DialogTypes.error)));
      }
    }
    return !permission.isDenied;
  } else {
    final permission = await Permission.photos.request();
    if (permission.isDenied && context.mounted) {
      unawaited(showPlatformAlert(context, ModelAlertDialog(description: R.string.accessGalleryPermission, dialogType: DialogTypes.error)));
    }
    return !permission.isDenied;
  }
}

Future<bool> accessGalleryVideosPermission(BuildContext context) async {
  if (kIsWeb) {
    return true;
  }
  if (!Platform.isAndroid) {
    final sdkInt = Provider.of<ServiceDeviceInfo>(context, listen: false).androidInfo!.version.sdkInt;
    late PermissionStatus permission;
    if (context.mounted) {
      permission = (Platform.isAndroid && sdkInt >= 33) ? PermissionStatus.granted : await Permission.storage.request();
      if (permission.isDenied && context.mounted) {
        unawaited(showPlatformAlert(context, ModelAlertDialog(description: R.string.accessGalleryPermission, dialogType: DialogTypes.error)));
      }
    }
    return !permission.isDenied;
  } else {
    final permission = await Permission.videos.request();
    if (permission.isDenied && context.mounted) {
      unawaited(showPlatformAlert(context, ModelAlertDialog(description: R.string.accessGalleryPermission, dialogType: DialogTypes.error)));
    }
    return !permission.isDenied;
  }
}

Future<bool> accessLocationPermission(BuildContext context) async {
  if (kIsWeb) {
    return true;
  }
  final permission = await Permission.location.request();
  if (permission.isDenied && context.mounted) {
    unawaited(showPlatformAlert(context, ModelAlertDialog(description: R.string.accessLocationPermission, dialogType: DialogTypes.error)));
  }
  return !permission.isDenied;
}

Future<bool> accessMicrophonePermission(BuildContext context) async {
  if (kIsWeb) {
    return true;
  }
  final permission = await Permission.microphone.request();
  if (permission.isDenied && context.mounted) {
    unawaited(showPlatformAlert(context, ModelAlertDialog(description: R.string.accessMicrophonePermission, dialogType: DialogTypes.error)));
  }
  return !permission.isDenied;
}
