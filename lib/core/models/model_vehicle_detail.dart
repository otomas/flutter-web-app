import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../enums/enum_api.dart';
import 'model_balance.dart';
import 'model_name.dart';
import 'model_purchase_payment.dart';
import 'model_value.dart';
import 'model_vehicle_detail_version.dart';
import 'model_vehicle_experties.dart';
import 'model_vehicle_info.dart';

@jsonSerializable
class ModelVehicleDetail {

  const ModelVehicleDetail({
    required this.id,
    required this.uuid,
    this.autoGalleryBranchId,
    this.supplierId,
    this.sellerId,
    this.buyerId,
    this.vehicleModelId,
    this.vehicleFuelTypeId,
    this.vehicleBodyTypeId,
    this.vehilceTransmissionTypeId,
    this.vehicleTractionTypeId,
    this.enginePower,
    this.engineCapacity,
    this.modelYear,
    this.plateNumber,
    this.chassisNumber,
    this.kilometer,
    this.color,
    this.balance,
    this.price,
    this.salesPrice,
    this.agreedSellingPrice,
    this.purchasedAt,
    this.salesAt,
    this.insuranceStartDate,
    this.insuranceEndDate,
    this.inspectionStartDate,
    this.inspectionEndDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.currentDollarIndex,
    this.dollarIndexedIncrease,
    this.purchasePayments,
    this.accountTransaction,
    this.supplier,
    this.buyer,
    this.seller,
    this.vehicleVersion,
    this.vehicleFuelType,
    this.vehicleBodyType,
    this.vehicleTransmissionType,
    this.vehicleTractionType,
    this.vehicleListingInformation,
    this.coverPhotoUrl,
    this.colorFlaws,
    this.adStatus,
  });
  final int id;
  final String uuid;

  @JsonProperty(name: 'auto_gallery_branch_id')
  final int? autoGalleryBranchId;

  @JsonProperty(name: 'supplier_id')
  final int? supplierId;

  @JsonProperty(name: 'seller_id')
  final int? sellerId;

  @JsonProperty(name: 'buyer_id')
  final int? buyerId;

  @JsonProperty(name: 'vehicle_model_id')
  final int? vehicleModelId;

  @JsonProperty(name: 'vehicle_fuel_type_id')
  final int? vehicleFuelTypeId;

  @JsonProperty(name: 'vehicle_body_type_id')
  final int? vehicleBodyTypeId;

  @JsonProperty(name: 'vehicle_transmission_type_id')
  final int? vehilceTransmissionTypeId;

  @JsonProperty(name: 'vehicle_traction_type_id')
  final int? vehicleTractionTypeId;

  @JsonProperty(name: 'engine_power')
  final int? enginePower;

  @JsonProperty(name: 'engine_capacity')
  final int? engineCapacity;

  @JsonProperty(name: 'model_year')
  final int? modelYear;

  @JsonProperty(name: 'plate_number')
  final String? plateNumber;

  @JsonProperty(name: 'chassis_number')
  final String? chassisNumber;

  final num? kilometer;
  final String? color;

  final ModelBalance? balance;
  final ModelBalance? price;

  @JsonProperty(name: 'sales_price')
  final ModelBalance? salesPrice;

  @JsonProperty(name: 'agreed_selling_price')
  final ModelBalance? agreedSellingPrice;

  @JsonProperty(name: 'purchased_at')
  final DateTime? purchasedAt;

  @JsonProperty(name: 'sales_at')
  final DateTime? salesAt;

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

  @JsonProperty(name: 'current_dollar_index')
  final ModelBalance? currentDollarIndex;

  @JsonProperty(name: 'dollar_indexed_increase')
  final ModelBalance? dollarIndexedIncrease;

  @JsonProperty(name: 'purchase_payments')
  final List<ModelPurchasePayment>? purchasePayments;

  @JsonProperty(name: 'account_transaction')
  final ModelAccountTransaction? accountTransaction;

  final ModelName? supplier;
  final ModelName? buyer;
  final ModelName? seller;

  @JsonProperty(name: 'vehicle_version')
  final ModelVehicleDetailInfo? vehicleVersion;

  @JsonProperty(name: 'vehicle_fuel_type')
  final ModelValue? vehicleFuelType;

  @JsonProperty(name: 'vehicle_body_type')
  final ModelValue? vehicleBodyType;

  @JsonProperty(name: 'vehicle_transmission_type')
  final ModelValue? vehicleTransmissionType;

  @JsonProperty(name: 'vehicle_traction_type')
  final ModelValue? vehicleTractionType;

  @JsonProperty(name: 'vehicle_listing_information')
  final ModelVehicleInfo? vehicleListingInformation;
  
  @JsonProperty(name: 'cover_photo_url')
  final String? coverPhotoUrl;

  @JsonProperty(name: 'color_flaws')
  final List<ModelVehicleExperties>? colorFlaws;

  
  @JsonProperty(name: 'ad_status')
  final AdStatus? adStatus;
}

@jsonSerializable
class ModelAccountTransaction {

  const ModelAccountTransaction({this.accountModel, this.accountId});
  @JsonProperty(name: 'account_model')
  final String? accountModel;

  @JsonProperty(name: 'account_id')
  final int? accountId;
}
