// ignore_for_file: avoid_classes_with_only_static_members, implementation_imports
import 'dart:async';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/foundation.dart';
import '../../main.reflectable.dart';
import '../services/service_json_mapper_context.dart';

class IsolateHelper {
  @pragma('vm:entry-point')
  static Future<T> parseJson<T>(Map<String, dynamic> data) async {
    final value = await compute(_parseJson<T>, data);
    return value!;
  }

  static Future<T> _parseJson<T>(Map<String, dynamic> data) async {
    initializeReflectable();
    ServiceJsonMapperContext();
    return JsonMapper.deserialize<T>(data)!;
  }
}
