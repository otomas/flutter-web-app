import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_model_detail.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleModelDetail extends ResponseData {
  const ModelResponseVehicleModelDetail({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelVehicleModelDetail? data;
}
