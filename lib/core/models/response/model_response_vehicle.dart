import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleList extends ResponseData {

  const ModelResponseVehicleList({
    super.status = false,
    super.error,
    this.data,
    this.recordsTotal,
  });
  final int? recordsTotal;
  final List<ModelVehicle>? data;
}
