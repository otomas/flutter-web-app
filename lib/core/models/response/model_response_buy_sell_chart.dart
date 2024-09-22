import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_buy_sell_chart.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseBuySellChart extends ResponseData {
  const ModelResponseBuySellChart({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelBuySellChart? data;
}
