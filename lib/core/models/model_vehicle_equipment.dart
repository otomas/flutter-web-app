import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelVehicleEquipment {
  ModelVehicleEquipment({
    this.id,
    this.name,
    this.canonicalName,
    this.description,
  });
  final int? id;
  final String? name;
  @JsonProperty(name: 'canonical_name')
  final String? canonicalName;
  final String? description;
}
