import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestVehicleInfo {

  const ModelRequestVehicleInfo({
    required this.title,
    required this.description,
    required this.priceDomestic,
    required this.priceForeign,
    required this.priceDomesticCurrencyTypeId,
    required this.priceForeignCurrencyTypeId,
  });
  final String title;
  final String description;

  @JsonProperty(name: 'price_domestic')
  final int priceDomestic;

  @JsonProperty(name: 'price_foreign')
  final int priceForeign;

  @JsonProperty(name: 'price_domestic_currency_type_id')
  final int priceDomesticCurrencyTypeId;

  @JsonProperty(name: 'price_foreign_currency_type_id')
  final int priceForeignCurrencyTypeId;
}
