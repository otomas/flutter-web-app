import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';

@jsonSerializable
class ModelVehicleInfo {

  const ModelVehicleInfo({
    required this.id,
    this.autoGalleryVehicleId,
    this.autoGalleryBranchId,
    this.title,
    this.description,
    this.priceDomestic,
    this.priceForeign,
  });
  final int id;
  @JsonProperty(name: 'auto_gallery_vehicle_id')
  final int? autoGalleryVehicleId;

  @JsonProperty(name: 'auto_gallery_branch_id')
  final int? autoGalleryBranchId;

  final String? title;
  final String? description;

  @JsonProperty(name: 'price_domestic')
  final ModelBalance? priceDomestic;

  @JsonProperty(name: 'price_foreign')
  final ModelBalance? priceForeign;
}
