import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_fuel_type.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleFuelTypes extends ResponseData {
  const ModelResponseVehicleFuelTypes({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleFuelType>? data;
}
