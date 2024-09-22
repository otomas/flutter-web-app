import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_customer.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseCustomerList extends ResponseData {
  const ModelResponseCustomerList({
    super.status = false,
    super.error,
    this.data,
    this.recordsTotal,
  });
  final int? recordsTotal;
  final List<ModelCustomer>? data;
}

@jsonSerializable
class ModelResponseCustomer extends ResponseData {
  const ModelResponseCustomer({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelCustomer? data;
}
