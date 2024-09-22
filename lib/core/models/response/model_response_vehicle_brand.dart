import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_vehicle_brands.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleBrands extends ResponseData {
  const ModelResponseVehicleBrands({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleBrand>? data;
}
