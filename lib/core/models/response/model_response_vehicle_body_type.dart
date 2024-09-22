import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_body_type.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleBodyTypes extends ResponseData {
  const ModelResponseVehicleBodyTypes({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleBodyType>? data;
}
