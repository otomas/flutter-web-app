import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../../extensions/extension_num.dart';
import '../model_balance.dart';
import '../model_pos_devices.dart';
import '../model_value.dart';
import '../model_vehicle_detail_version.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseMarketplace extends ResponseData {
  const ModelResponseMarketplace({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelMarketplaceResponse? data;
}

@jsonSerializable
class ModelMarketplaceResponse {
  const ModelMarketplaceResponse({this.ads, this.filters});

  final List<ModelMarketplaceAds>? ads;
  final ModelMarketplaceResponseFilter? filters;
}

@jsonSerializable
class ModelMarketplaceAds {
  const ModelMarketplaceAds({
    required this.id,
    required this.uuid,
    required this.autoGalleryVehicleId,
    required this.autoGalleryBranchId,
    required this.adStatusId,
    required this.vehicleVersionId,
    required this.vehicleFuelTypeId,
    required this.vehicleBodyTypeId,
    required this.vehicleTransmissionTypeId,
    required this.vehicleTractionTypeId,
    required this.priceDomesticCurrencyTypeId,
    required this.priceForeignCurrencyTypeId,
    required this.isPublishPriceDomestic,
    this.vehicleFuelType,
    this.vehicleTransmissionType,
    this.enginePower,
    this.engineCapacity,
    this.modelYear,
    this.plateNumber,
    this.chassisNumber,
    this.kilometer,
    this.color,
    this.title,
    this.description,
    this.priceDomestic,
    this.insuranceStartDate,
    this.insuranceEndDate,
    this.inspectionStartDate,
    this.inspectionEndDate,
    this.coverPhotoUrl,
    this.autoGalleryBranch,
    this.vehicleVersion,
  });

  final int id;

  final String uuid;

  @JsonProperty(name: 'auto_gallery_vehicle_id')
  final int autoGalleryVehicleId;

  @JsonProperty(name: 'auto_gallery_branch_id')
  final int autoGalleryBranchId;

  @JsonProperty(name: 'ad_status_id')
  final int adStatusId;

  @JsonProperty(name: 'vehicle_version_id')
  final int vehicleVersionId;

  @JsonProperty(name: 'vehicle_fuel_type_id')
  final int vehicleFuelTypeId;

  @JsonProperty(name: 'vehicle_fuel_type')
  final ModelValue? vehicleFuelType;

  @JsonProperty(name: 'vehicle_body_type_id')
  final int vehicleBodyTypeId;

  @JsonProperty(name: 'vehicle_transmission_type_id')
  final int vehicleTransmissionTypeId;
  
  @JsonProperty(name: 'vehicle_transmission_type')
  final ModelValue? vehicleTransmissionType;

  @JsonProperty(name: 'vehicle_traction_type_id')
  final int vehicleTractionTypeId;

  @JsonProperty(name: 'price_domestic_currency_type_id')
  final int priceDomesticCurrencyTypeId;

  @JsonProperty(name: 'price_foreign_currency_type_id')
  final int priceForeignCurrencyTypeId;

  @JsonProperty(name: 'engine_power')
  final num? enginePower;

  @JsonProperty(name: 'engine_capacity')
  final num? engineCapacity;

  @JsonProperty(name: 'model_year')
  final String? modelYear;

  @JsonProperty(name: 'plate_number')
  final String? plateNumber;

  @JsonProperty(name: 'chassis_number')
  final String? chassisNumber;

  final num? kilometer;
  final String? color;
  final String? title;
  final String? description;

  @JsonProperty(name: 'price_domestic')
  final ModelBalance? priceDomestic;

  @JsonProperty(name: 'is_publish_price_domestic')
  final bool isPublishPriceDomestic;

  @JsonProperty(name: 'insurance_start_date', ignoreIfNull: true)
  final DateTime? insuranceStartDate;

  @JsonProperty(name: 'insurance_end_date', ignoreIfNull: true)
  final DateTime? insuranceEndDate;

  @JsonProperty(name: 'inspection_start_date', ignoreIfNull: true)
  final DateTime? inspectionStartDate;

  @JsonProperty(name: 'inspection_end_date', ignoreIfNull: true)
  final DateTime? inspectionEndDate;

  @JsonProperty(name: 'cover_photo_url')
  final String? coverPhotoUrl;

  @JsonProperty(name: 'auto_gallery_branch')
  final ModelAutoGalleryBranch? autoGalleryBranch;
  
  @JsonProperty(name: 'vehicle_version')
  final ModelVehicleDetailInfo? vehicleVersion;


  String get shortInfo => '${modelYear ?? ''}      ${kilometer.formatPrice()} km      ${vehicleFuelType?.name ?? ''}      ${vehicleTransmissionType?.name ?? ''}';
}


@jsonSerializable
class ModelMarketplaceResponseFilter {
  const ModelMarketplaceResponseFilter({
    this.vehicleBrand,
    this.vehicleSeries,
    this.vehicleModel,
    this.vehicleVersion,
    this.province,
    this.district,
    this.fuelTypes,
    this.transmissionTypes,
    this.bodyTypes,
    this.tractionTypes,
  });

  @JsonProperty(name: 'vehicle_brand')
  final ModelValue? vehicleBrand;

  @JsonProperty(name: 'vehicle_series')
  final ModelValue? vehicleSeries;

  @JsonProperty(name: 'vehicle_model')
  final ModelValue? vehicleModel;

  @JsonProperty(name: 'vehicle_version')
  final ModelValue? vehicleVersion;

  final ModelValue? province;
  final ModelValue? district;

  @JsonProperty(name: 'fuel_types')
  final List<ModelValue>? fuelTypes;

  @JsonProperty(name: 'transmission_types')
  final List<ModelValue>? transmissionTypes;

  @JsonProperty(name: 'body_types')
  final List<ModelValue>? bodyTypes;

  @JsonProperty(name: 'traction_types')
  final List<ModelValue>? tractionTypes;
}
