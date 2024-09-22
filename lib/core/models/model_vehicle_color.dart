import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_base_dropdown.dart';

@jsonSerializable
class ModelVehicleColor implements BaseDropdown {

  const ModelVehicleColor({
    required this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  final int id;

  final String? name;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;

  @JsonProperty(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonProperty(name: 'deleted_at')
  final DateTime? deletedAt;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}
