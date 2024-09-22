import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';
import 'model_base_dropdown.dart';
import 'model_query_result.dart';

import 'model_value_status.dart';

@jsonSerializable
class ModelQuery implements BaseDropdown {

  const ModelQuery({
    required this.id,
    this.autoGalleryId,
    this.autoGalleryVehicleId,
    this.userId,
    this.vehicleDamageRecordQueryResultId,
    this.price,
    this.apiPrice,
    this.partAmount,
    this.laborAmount,
    this.total,
    this.status,
    this.kilometer,
    this.errorCode,
    this.errorDescription,
    this.createdAt,
    this.updatedAt,
    this.plateNumber,
    this.chassisNumber,
    this.date,
    this.reason,
    this.vehicleDamageRecordQueryResult,
  });
  final int id;

  @JsonProperty(name: 'auto_gallery_id')
  final int? autoGalleryId;

  @JsonProperty(name: 'auto_gallery_vehicle_id')
  final int? autoGalleryVehicleId;

  @JsonProperty(name: 'user_id')
  final int? userId;

  @JsonProperty(name: 'vehicle_damage_record_query_result_id')
  final int? vehicleDamageRecordQueryResultId;

  final ModelBalance? price;

  @JsonProperty(name: 'api_price')
  final ModelBalance? apiPrice;

  @JsonProperty(name: 'part_amount')
  final ModelBalance? partAmount;

  @JsonProperty(name: 'labor_amount')
  final ModelBalance? laborAmount;

  final ModelBalance? total;
  final ModelValueStatus? status;
  final int? kilometer;

  @JsonProperty(name: 'error_code')
  final String? errorCode;

  @JsonProperty(name: 'error_description')
  final String? errorDescription;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;

  @JsonProperty(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonProperty(name: 'plate_number')
  final String? plateNumber;

  @JsonProperty(name: 'chassis_number')
  final String? chassisNumber;

  final String? date;
  final String? reason;

  @JsonProperty(name: 'vehicle_damage_record_query_result')
  final ModelQueryResult? vehicleDamageRecordQueryResult;
  
  @override
  String get dropdownId => id.toString();
  
  @override
  String get dropdownTitle => plateNumber ?? chassisNumber ?? '-';
}
