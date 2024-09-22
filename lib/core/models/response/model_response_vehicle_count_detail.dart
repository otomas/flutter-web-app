import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleCountDetail extends ResponseData {
  const ModelResponseVehicleCountDetail({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelVehicleCountDetail? data;
}

@jsonSerializable
class ModelVehicleCountDetail {
  const ModelVehicleCountDetail({
    required this.vehicleCount,
    required this.consigneeCount,
    required this.inventoryCount,
    required this.marketPlaceCount,
    required this.salesCount,
    required this.deletedCount,
  });
  final int vehicleCount;
  final int consigneeCount;
  final int inventoryCount;
  final int marketPlaceCount;
  final int salesCount;
  final int deletedCount;
}
