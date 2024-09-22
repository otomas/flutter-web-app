import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';

@jsonSerializable
class ModelQueryResult {

  const ModelQueryResult({
    required this.id,
    this.vehicleDamageRecordQueryId,
    this.date,
    this.reason,
    this.amount,
    this.isPartChange,
    this.createdAt,
    this.updatedAt,
  });
  final int id;

  @JsonProperty(name: 'vehicle_damage_record_query_id')
  final int? vehicleDamageRecordQueryId;

  final DateTime? date;
  final String? reason;
  final ModelBalance? amount;

  @JsonProperty(name: 'is_part_change')
  final int? isPartChange;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;

  @JsonProperty(name: 'updated_at')
  final DateTime? updatedAt;
}
