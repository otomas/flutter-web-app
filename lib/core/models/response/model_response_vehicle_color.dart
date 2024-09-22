import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_color.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleColors extends ResponseData {
  const ModelResponseVehicleColors({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleColor>? data;
}
