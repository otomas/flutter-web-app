import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../response_data.dart';
import 'model_transaction_categories.dart';

@jsonSerializable
class ModelResponseTransactionCategories extends ResponseData {
  const ModelResponseTransactionCategories({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelTransactionCategories>? data;
}
