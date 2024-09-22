import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestDeviceRegister {

  const ModelRequestDeviceRegister({
    required this.id,
    this.macAddress,
    this.platform,
    this.ipAddress,
    this.fcmToken,
    this.longitude,
    this.latitude,
  });
  final String id;
  final String? macAddress;
  final String? platform;
  final String? ipAddress;
  final String? fcmToken;
  final num? longitude;
  final num? latitude;
}

@jsonSerializable
class ModelRequestDeviceUpdate {

  const ModelRequestDeviceUpdate({
    this.ipAddress,
    this.fcmToken,
    this.longitude,
    this.latitude,
  });
  final String? ipAddress;
  final String? fcmToken;
  final num? longitude;
  final num? latitude;
}
