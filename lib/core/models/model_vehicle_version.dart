import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_base_dropdown.dart';

@jsonSerializable
class ModelVehicleVersion implements BaseDropdown {

  const ModelVehicleVersion({
    required this.id,
    this.refId,
    this.vehicleModelId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  final int id;

  @JsonProperty(name: 'ref_id')
  final String? refId;

  @JsonProperty(name: 'vehicle_model_id')
  final int? vehicleModelId;


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
