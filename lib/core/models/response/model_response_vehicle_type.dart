import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_type.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleTypes extends ResponseData {
  const ModelResponseVehicleTypes({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleType>? data;
}
