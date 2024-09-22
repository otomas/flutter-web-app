import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_balance.dart';
import '../model_vehicle_detail_version.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleListingInfo extends ResponseData {
  const ModelResponseVehicleListingInfo({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelVehicleListingInfoResponse? data;
}

@jsonSerializable
class ModelVehicleListingInfoResponse {
  const ModelVehicleListingInfoResponse({
    required this.id,
    required this.uuid,
    required this.vehicleVersionId,
    this.plateNumber,
    this.vehicleVersion,
    this.vehicleListingInformation,
    this.coverPhotoUrl,
  });

  final int id;
  final String? uuid;

  @JsonProperty(name: 'vehicle_version_id')
  final int vehicleVersionId;

  @JsonProperty(name: 'plate_number')
  final String? plateNumber;

  @JsonProperty(name: 'cover_photo_url')
  final String? coverPhotoUrl;

  @JsonProperty(name: 'vehicle_version')
  final ModelVehicleDetailInfo? vehicleVersion;

  @JsonProperty(name: 'vehicle_listing_information')
  final ModelVehicleListingInfo? vehicleListingInformation;
}

@jsonSerializable
class ModelVehicleListingInfo {
  const ModelVehicleListingInfo({
    required this.id,
    required this.autoGalleryVehicleId,
    required this.autoGalleryBranchId,
    required this.isPublishPriceDomestic,
    required this.isPublishPriceForeign,
    this.title,
    this.description,
    this.priceDomestic,
    this.priceForeign,
  });

  final int id;

  @JsonProperty(name: 'auto_gallery_vehicle_id')
  final int autoGalleryVehicleId;

  @JsonProperty(name: 'auto_gallery_branch_id')
  final int autoGalleryBranchId;

  final String? title;
  final String? description;

  @JsonProperty(name: 'price_domestic')
  final ModelBalance? priceDomestic;

  @JsonProperty(name: 'price_foreign')
  final ModelBalance? priceForeign;

  @JsonProperty(name: 'is_publish_price_domestic', defaultValue: false)
  final bool isPublishPriceDomestic;

  @JsonProperty(name: 'is_publish_price_foreign', defaultValue: false)
  final bool isPublishPriceForeign;
}
