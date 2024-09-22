import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_series.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleSeries extends ResponseData {
  const ModelResponseVehicleSeries({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleSeries>? data;
}
