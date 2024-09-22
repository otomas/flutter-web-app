import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'model_base_dropdown.dart';
import 'model_value.dart';

@jsonSerializable
class ModelVehicleSeries implements BaseDropdown {

  const ModelVehicleSeries({
    required this.id,
    this.refId,
    this.vehicleTypeId,
    this.vehicleBrandId,
    this.vehicleBrand,
    this.vehicleType,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  final int id;

  @JsonProperty(name: 'ref_id')
  final int? refId;

  @JsonProperty(name: 'vehicle_type_id')
  final int? vehicleTypeId;

  @JsonProperty(name: 'vehicle_brand_id')
  final int? vehicleBrandId;
  
  @JsonProperty(name: 'vehicle_brand')
  final ModelValue? vehicleBrand;
  
  @JsonProperty(name: 'vehicle_type')
  final ModelValue? vehicleType;

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
