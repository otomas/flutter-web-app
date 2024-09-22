import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_version.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleVersions extends ResponseData {
  const ModelResponseVehicleVersions({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleVersion>? data;
}
