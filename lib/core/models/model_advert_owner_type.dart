import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelAdwertOwnerType {

  const ModelAdwertOwnerType({
    this.id,
    this.name,
    this.icon,
  });
  final num? id;
  final String? name;
  final String? icon;
}
