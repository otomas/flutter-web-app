import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_payment_type.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponsePaymentTypes extends ResponseData {
  const ModelResponsePaymentTypes({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelPaymentType>? data;
}
