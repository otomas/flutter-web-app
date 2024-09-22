import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestAddPhoto {
  const ModelRequestAddPhoto(this.files);
  
  final List<String> files;
}
