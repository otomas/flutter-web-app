import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../enums/enum_api.dart';
import 'model_balance.dart';

@jsonSerializable
class ModelPurchasePayment {
  const ModelPurchasePayment({
    required this.paymentTypeId,
    this.paymentType,
    this.paymentLocation,
    this.paymentLocationId,
    this.amount,
    this.processedBy,
  });
  @JsonProperty(name: 'payment_type_id')
  final PaymentType paymentTypeId;

  @JsonProperty(name: 'payment_type')
  final String? paymentType;

  @JsonProperty(name: 'payment_location')
  final String? paymentLocation;

  @JsonProperty(name: 'payment_location_id')
  final int? paymentLocationId;

  final ModelBalance? amount;

  @JsonProperty(name: 'processed_by')
  final String? processedBy;
}
