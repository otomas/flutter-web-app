import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../model_vehicle_traction_type.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleTractionType extends ResponseData {
  const ModelResponseVehicleTractionType({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleTractionType>? data;
}
