import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_transmission_type.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleTranmissionType extends ResponseData {
  const ModelResponseVehicleTranmissionType({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleTransmissionType>? data;
}
