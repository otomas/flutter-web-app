import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'model_vehicle_model.dart';

@jsonSerializable
class ModelVehicleDetailInfo {
  const ModelVehicleDetailInfo({
    required this.id,
    this.name,
    this.vehicleModelId,
    this.vehicleModel,
  });

  final int id;
  final String? name;

  @JsonProperty(name: 'vehicle_model_id')
  final int? vehicleModelId;

  @JsonProperty(name: 'vehicle_model')
  final ModelVehicleModel? vehicleModel;

  String get brandModelVersion => '${vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''} ${vehicleModel?.vehicleSeries?.name ?? ''} ${vehicleModel?.name ?? ''} ${name ?? ''}';
}
