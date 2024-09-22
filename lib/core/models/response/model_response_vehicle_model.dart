import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_model.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleModels extends ResponseData {
  const ModelResponseVehicleModels({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleModel>? data;
}
