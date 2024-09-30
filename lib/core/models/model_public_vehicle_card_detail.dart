import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../extensions/extension_num.dart';
import 'model_balance.dart';
import 'model_photo.dart';

@jsonSerializable
class ModelPublicVehicleCardDetail {
  const ModelPublicVehicleCardDetail(
    this.id,
    this.modelYear,
    this.kilometer,
    this.priceForeign,
    this.modelName,
    this.fuelTypeName,
    this.transmissionTypeName,
    this.location,
    this.photos,
    this.autoGalleryName,
  );

  final int? id;

  @JsonProperty(name: 'model_year')
  final String? modelYear;

  final int? kilometer;

  @JsonProperty(name: 'price_foreign')
  final ModelBalance? priceForeign;

  @JsonProperty(name: 'model_name')
  final String? modelName;

  @JsonProperty(name: 'fuel_type_name')
  final String? fuelTypeName;

  @JsonProperty(name: 'auto_gallery_name')
  final String? autoGalleryName;

  @JsonProperty(name: 'transmission_type_name')
  final String? transmissionTypeName;

  final String? location;
  final List<ModelPhoto> photos;

  String get shortInfo => '${modelYear ?? ''}      ${kilometer.formatPrice()} km      ${fuelTypeName ?? ''}      ${transmissionTypeName ?? ''}';
}
