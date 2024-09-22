import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_detail.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleDetail extends ResponseData {
  const ModelResponseVehicleDetail({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelVehicleDetail? data;
}
