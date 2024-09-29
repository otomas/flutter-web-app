import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelPublicVehicleBar {
  const ModelPublicVehicleBar(this.typeName, this.type, this.count, this.icon, this.id);
  
  @JsonProperty(name: 'type_id')
  final int? id;

  @JsonProperty(name: 'type_name')
  final String? typeName;

  final String? type;
  final String? icon;
  final int? count;
}
