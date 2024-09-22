import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'model_balance.dart';
import 'model_base_dropdown.dart';
import 'model_name.dart';
import 'model_value.dart';
import 'model_value_label.dart';
import 'model_vehicle_detail_version.dart';

@jsonSerializable
class ModelVehicle extends BaseDropdown{

  ModelVehicle({
    required this.autoGalleryBranchId,
    required this.id,
    this.vehicleTransmissionTypeId,
    this.vehicleFuelTypeId,
    this.kilometer,
    this.vehicleTransmissionType,
    this.vehicleFuelType,
    this.credit,
    this.plateNumber,
    this.vehicleModelId,
    this.modelYear,
    this.color,
    this.balance,
    this.price,
    this.salesPrice,
    this.supplierId,
    this.sellerId,
    this.buyerId,
    this.vehicleTractionType,
    this.vehicleVersion,
    this.supplier,
    this.seller,
    this.buyer,
    this.avatar,
    this.isLpgExists,
    this.enginePower,
    this.engineCapacity,
    this.recordsTotal,
  });
  @JsonProperty(name: 'auto_gallery_branch_id')
  final int autoGalleryBranchId;

  final int id;

  @JsonProperty(name: 'plate_number')
  final String? plateNumber;

  @JsonProperty(name: 'vehicle_model_id')
  final int? vehicleModelId;

  @JsonProperty(name: 'model_year')
  final String? modelYear;

  final String? color;
  final ModelBalance? balance;
  final ModelBalance? price;

  @JsonProperty(name: 'sales_price')
  final ModelBalance? salesPrice;

  @JsonProperty(name: 'supplier_id')
  final int? supplierId;

  @JsonProperty(name: 'seller_id')
  final int? sellerId;

  @JsonProperty(name: 'buyer_id')
  final int? buyerId;

  @JsonProperty(name: 'vehicle_transmission_type_id')
  final int? vehicleTransmissionTypeId;

  @JsonProperty(name: 'vehicle_fuel_type_id')
  final int? vehicleFuelTypeId;

  final num? kilometer;

  @JsonProperty(name: 'vehicle_traction_type')
  final String? vehicleTractionType;

  @JsonProperty(name: 'vehicle_version')
  final ModelVehicleDetailInfo? vehicleVersion;

  final ModelName? supplier;
  final ModelName? seller;
  final ModelName? buyer;

  @JsonProperty(name: 'vehicle_transmission_type')
  final ModelValue? vehicleTransmissionType;

  @JsonProperty(name: 'vehicle_fuel_type')
  final ModelValue? vehicleFuelType;

  final String? avatar;

  @JsonProperty(name: 'is_lpg_exists')
  final ModelValueLabel? isLpgExists;

  @JsonProperty(name: 'engine_power')
  final num? enginePower;

  final ModelBalance? credit;

  @JsonProperty(name: 'engine_capacity')
  final num? engineCapacity;

  String get brandFullName => '${vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? '-'} ${vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? '-'}';

  final num? recordsTotal;
  
  @override
  String get dropdownId => id.toString();
  
  @override
  String get dropdownTitle => plateNumber ?? '';
}
