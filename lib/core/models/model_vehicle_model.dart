import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_base_dropdown.dart';
import 'model_vehicle_series.dart';

@jsonSerializable
class ModelVehicleModel implements BaseDropdown {

  const ModelVehicleModel({
    required this.id,
    this.refId,
    this.vehicleSeriesId,
    this.vehicleSeries,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  final int id;

  @JsonProperty(name: 'ref_id')
  final int? refId;

  @JsonProperty(name: 'vehicle_series_id')
  final int? vehicleSeriesId;

  @JsonProperty(name: 'vehicle_series')
  final ModelVehicleSeries? vehicleSeries;

  final String? name;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;

  @JsonProperty(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonProperty(name: 'deleted_at')
  final DateTime? deletedAt;

  String getTitle() => '${vehicleSeries?.vehicleBrand?.name ?? ''} ${vehicleSeries?.name ?? ''} $name';

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}
