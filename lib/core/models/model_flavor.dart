import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelFlavor {
  const ModelFlavor({
    required this.baseUrl,
    required this.fileUrl,
    required this.appName,
  });
  final String baseUrl;
  final String fileUrl;
  final String appName;
}
