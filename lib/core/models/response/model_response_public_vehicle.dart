import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_public_vehicle_list.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponsePublicVehicle extends ResponseData {
  const ModelResponsePublicVehicle({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelVehicleResponse? data;
}
