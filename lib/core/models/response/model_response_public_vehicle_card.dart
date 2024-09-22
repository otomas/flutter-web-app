import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_public_vehicle_card_detail.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponsePublicVehicleCard extends ResponseData {
  const ModelResponsePublicVehicleCard({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelPublicVehicleCardDetail>? data;
}
