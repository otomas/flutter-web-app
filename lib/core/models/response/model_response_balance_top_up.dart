import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_balance_top_up.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseBalanceTopUp extends ResponseData {
  const ModelResponseBalanceTopUp({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelBalanceTopUp>? data;
}
