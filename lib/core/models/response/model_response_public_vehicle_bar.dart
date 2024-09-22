import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_public_vehicle_bar.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponsePublicVehicleBar extends ResponseData {
  const ModelResponsePublicVehicleBar({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelPublicVehicleBar>? data;
}
