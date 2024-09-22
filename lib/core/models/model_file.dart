import 'dart:typed_data';

import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

import '../enums/enum_app.dart';

@jsonSerializable
class ModelFile {
  ModelFile({required this.path, required this.type, this.isNetwork = false, this.byte});

  final String path;
  FileType type;
  final bool isNetwork;
  Uint8List? byte;
}
