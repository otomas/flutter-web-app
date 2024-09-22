import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_turnover.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseTurnover extends ResponseData {

  const ModelResponseTurnover({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelTurnover? data;
}
