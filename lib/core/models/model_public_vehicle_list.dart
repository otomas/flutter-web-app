import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'model_balance.dart';
import 'model_photo.dart';
import 'model_pos_devices.dart';
import 'model_vehicle_body_type.dart';
import 'model_vehicle_detail_version.dart';
import 'model_vehicle_equipment.dart';
import 'model_vehicle_experties.dart';
import 'model_vehicle_fuel_type.dart';
import 'model_vehicle_traction_type.dart';
import 'model_vehicle_transmission_type.dart';

@jsonSerializable
class ModelVehicleResponse {
  const ModelVehicleResponse({
    required this.id,
    this.uuid,
    this.autoGalleryVehicleId,
    this.autoGalleryBranchId,
    this.adStatusId,
    this.vehicleVersionId,
    this.vehicleFuelTypeId,
    this.vehicleBodyTypeId,
    this.vehicleTransmissionTypeId,
    this.vehicleTractionTypeId,
    this.vehicleTractionType,
    this.priceDomesticCurrencyTypeId,
    this.priceForeignCurrencyTypeId,
    this.modelYear,
    this.plateNumber,
    this.chassisNumber,
    this.priceDomestic,
    this.isPublishPriceDomestic,
    this.priceForeign,
    this.isPublishPriceForeign,
    this.insuranceStartDate,
    this.insuranceEndDate,
    this.inspectionStartDate,
    this.inspectionEndDate,
    this.createdAt,
    this.updatedAt,
    this.coverPhotoUrl,
    this.bodyworkFlaws,
    this.colorFlaws,
    this.autoGalleryBranch,
    this.vehicleVersion,
    this.vehicleFuelType,
    this.vehicleBodyType,
    this.vehicleTransmissionType,
    this.photos,
    this.deletedAt,
    this.enginePower,
    this.engineCapacity,
    this.kilometer,
    this.color,
    this.title,
    this.credit,
    this.description,
    this.settings,
    this.vehicleExteriorEquipments,
    this.vehicleInteriorEquipments,
    this.vehicleMultimedias,
    this.vehicleSecurityEquipments,
    this.adNumber,
  });

  final int id;
  final String? uuid;
  
  @JsonProperty(name: 'ad_number')
  final num? adNumber;

  @JsonProperty(name: 'auto_gallery_vehicle_id')
  final int? autoGalleryVehicleId;

  @JsonProperty(name: 'auto_gallery_branch_id')
  final int? autoGalleryBranchId;

  @JsonProperty(name: 'ad_status_id')
  final int? adStatusId;

  @JsonProperty(name: 'vehicle_version_id')
  final int? vehicleVersionId;

  @JsonProperty(name: 'vehicle_fuel_type_id')
  final int? vehicleFuelTypeId;

  @JsonProperty(name: 'vehicle_body_type_id')
  final int? vehicleBodyTypeId;

  @JsonProperty(name: 'vehicle_transmission_type_id')
  final int? vehicleTransmissionTypeId;

  @JsonProperty(name: 'vehicle_traction_type_id')
  final int? vehicleTractionTypeId;

  @JsonProperty(name: 'price_domestic_currency_type_id')
  final int? priceDomesticCurrencyTypeId;

  @JsonProperty(name: 'price_foreign_currency_type_id')
  final int? priceForeignCurrencyTypeId;

  @JsonProperty(name: 'model_year')
  final String? modelYear;

  @JsonProperty(name: 'plate_number')
  final String? plateNumber;

  @JsonProperty(name: 'chassis_number')
  final String? chassisNumber;

  @JsonProperty(name: 'price_domestic')
  final ModelBalance? priceDomestic;

  @JsonProperty(name: 'is_publish_price_domestic')
  final bool? isPublishPriceDomestic;

  @JsonProperty(name: 'price_foreign')
  final ModelBalance? priceForeign;

  @JsonProperty(name: 'is_publish_price_foreign')
  final bool? isPublishPriceForeign;

  @JsonProperty(name: 'insurance_start_date')
  final DateTime? insuranceStartDate;

  @JsonProperty(name: 'insurance_end_date')
  final DateTime? insuranceEndDate;

  @JsonProperty(name: 'inspection_start_date')
  final DateTime? inspectionStartDate;

  @JsonProperty(name: 'inspection_end_date')
  final DateTime? inspectionEndDate;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;

  @JsonProperty(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonProperty(name: 'deleted_at')
  final DateTime? deletedAt;

  @JsonProperty(name: 'cover_photo_url')
  final String? coverPhotoUrl;

  @JsonProperty(name: 'bodywork_flaws')
  final List<String>? bodyworkFlaws;

  @JsonProperty(name: 'color_flaws')
  final List<ModelVehicleExperties>? colorFlaws;

  @JsonProperty(name: 'auto_gallery_branch')
  final ModelAutoGalleryBranch? autoGalleryBranch;

  @JsonProperty(name: 'vehicle_version')
  final ModelVehicleDetailInfo? vehicleVersion;

  @JsonProperty(name: 'vehicle_fuel_type')
  final ModelVehicleFuelType? vehicleFuelType;

  @JsonProperty(name: 'vehicle_body_type')
  final ModelVehicleBodyType? vehicleBodyType;

  @JsonProperty(name: 'vehicle_transmission_type')
  final ModelVehicleTransmissionType? vehicleTransmissionType;

  @JsonProperty(name: 'vehicle_traction_type')
  final ModelVehicleTractionType? vehicleTractionType;

  @JsonProperty(name: 'photos')
  final List<ModelPhoto>? photos;

  @JsonProperty(name: 'vehicle_exterior_equipments')
  final List<ModelVehicleEquipment>? vehicleExteriorEquipments;
  
  @JsonProperty(name: 'vehicle_interior_equipments')
  final List<ModelVehicleEquipment>? vehicleInteriorEquipments;

  @JsonProperty(name: 'vehicle_multimedias')
  final List<ModelVehicleEquipment>? vehicleMultimedias;

  @JsonProperty(name: 'vehicle_security_equipments')
  final List<ModelVehicleEquipment>? vehicleSecurityEquipments;

  final int? enginePower;
  final int? engineCapacity;
  final int? kilometer;
  final String? color;
  final String? title;
  final String? description;
  final ModelBalance? credit;
  final String? settings;
}
