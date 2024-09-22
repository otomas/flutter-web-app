import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
// ignore: library_prefixes
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:jwt_decode/jwt_decode.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/app_config.dart';
import '../enums/enum_app.dart';
import '../models/response/model_response_login.dart';
import '../services/service_api.dart';
import '../services/service_firebase.dart';
import 'general_data.dart';
import 'launch_intent.dart';

Future<bool> isOnline() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

dynamic getUserSp(String id, {dynamic defaultValue}) {
  if (GeneralData.getInstance().hive != null) {
    return GeneralData.getInstance().hive!.get(id, defaultValue: defaultValue);
  }
  return defaultValue;
}

Future<void> setUserSp(String id, dynamic value) async => GeneralData.getInstance().hive?.put(id, value);

Future<void> openStore(String appStoreId, String playStoreId) async {
  if (Platform.isAndroid || Platform.isIOS) {
    final appId = Platform.isAndroid ? playStoreId : appStoreId;
    final url = Uri.parse(
      Platform.isAndroid ? 'market://details?id=$appId' : 'https://apps.apple.com/app/id$appId',
    );
    await launchUrl(
      url.toString(),
      mode: LaunchMode.externalApplication,
    );
  }
}

Future<void> openStoreReview(String appStoreId, String playStoreId) async {
  final inAppReview = InAppReview.instance;
  if (await inAppReview.isAvailable()) {
    await inAppReview.requestReview();
  } else {
    await inAppReview.openStoreListing();
  }
}

Future<String> printIps() async {
  var address = '';
  for (final interface in await NetworkInterface.list()) {
    for (final addr in interface.addresses) {
      address = addr.address;
    }
  }
  return address;
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  final days = <DateTime>[];
  for (var i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  return days;
}

Future<ModelToken?> parseToken(ServiceFirebase serviceFirebase, String? token) async {
  ModelToken? modelToken;
  if (token != null) {
    try {
      final data = convertToJsonForNotEqualQuotes(Jwt.parseJwt(token).toString());
      modelToken = JsonMapper.deserialize<ModelToken>(data);
    } on Exception catch (e) {
      await serviceFirebase.recordError(parameters: {'error': 'Token: $token ~ Auth Token deserialize error: $e'});
    }
  }
  return modelToken;
}

String convertToJsonForNotEqualQuotes(String str) {
  str = str.replaceAll('{', '{"');
  str = str.replaceAll(': ', '": "');
  str = str.replaceAll(', ', '", "');
  str = str.replaceAll('}', '"}');
  return str;
}

Future<ui.Image> getImage(String path) async {
  final completer = Completer<ImageInfo>();
  final img = NetworkImage(path);
  img.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener((info, _) {
      completer.complete(info);
    }),
  );
  final imageInfo = await completer.future;
  return imageInfo.image;
}

Future<File?> compressImage(String imageUrl, String filePath, {bool isNetwork = true}) async {
  late Uint8List? bytes;
  if (isNetwork) {
    bytes = await FlutterImageCompress.compressWithList(
      (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl)).buffer.asUint8List(),
      minWidth: 200,
      minHeight: 200,
      quality: 50,
    );
  } else {
    bytes = await FlutterImageCompress.compressWithFile(
      imageUrl,
      minWidth: 200,
      minHeight: 200,
      quality: 50,
    );
  }

  if (bytes != null) {
    return File(filePath).writeAsBytes(bytes, flush: true);
  }
  return null;
}

Future<bool> downloadNetworkFile(Uri fileUri) async {
  final dir = await appFiledir();
  final fileName = fileUri.path.split('/').last;
  final file = File('$dir/$fileName');
  final res = await Dio().downloadUri(fileUri, file.path);
  return res.statusCode == 200;
}

Future<String?> createFileFromBase64(String base64String, [bool isDownload = false]) async {
  if (!foundation.kIsWeb) {
    final bytes = base64.decode(base64String);
    final dir = isDownload ? await appFiledir() : (await getApplicationDocumentsDirectory()).path;
    final file = File('$dir/${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(bytes);
    return file.path;
  }
  // TODO(web): add network image download functions.
  return null;
}

void clearUserData(ServiceApi apiService) {
  unawaited(GeneralData.getInstance().setTokenData(null));
  unawaited(GeneralData.getInstance().setAuthToken(null));
  unawaited(GeneralData.getInstance().setAuthState(AuthState.unauthenticated));
  unawaited(GeneralData.getInstance().setUsername(null));
  unawaited(GeneralData.getInstance().setPassword(null));
  unawaited(GeneralData.getInstance().setTaxNumber(null));
  unawaited(GeneralData.getInstance().setRememberMe(false));
  apiService
    ..setAuthToken(null)
    ..setTaxNumber(null);
}
