import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelFinance {

  ModelFinance({required this.title, required this.value, required this.currency, required this.actionButtonText, required this.isTotal, this.routeIndex});
  final String title;
  final num value;
  final String currency;
  final String actionButtonText;
  final bool isTotal;

  String get amountForCurrency => currency;

  @JsonProperty(ignore: true)
  int? routeIndex;
}
