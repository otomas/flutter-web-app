import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelBalance {

  const ModelBalance({
    this.name,
    this.code,
    this.symbol,
    this.amount,
  });
  final String? name;
  final String? code;
  final String? symbol;
  final num? amount;
}
