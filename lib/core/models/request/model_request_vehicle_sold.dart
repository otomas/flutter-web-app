import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'model_request_payment_type.dart';

@jsonSerializable
class ModelRequestVehicleSold {

  const ModelRequestVehicleSold({
    required this.buyerId,
    required this.salesAt,
    required this.payments,
    required this.agreedSellingPrice,
  });
  @JsonProperty(name: 'buyer_id')
  final int buyerId;

  @JsonProperty(name: 'sales_at', converterParams: {'format': 'yyyy-MM-dd'})
  final DateTime salesAt;

  final List<ModelRequestPaymentType> payments;

  @JsonProperty(name: 'agreed_selling_price')
  final int agreedSellingPrice;
}
