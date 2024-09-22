import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestPublishAd {
  const ModelRequestPublishAd({required this.isPublishPriceDomestic, required this.isPublishPriceForeign});

  @JsonProperty(name: 'is_publish_price_domestic')
  final int isPublishPriceDomestic;

  @JsonProperty(name: 'is_publish_price_foreign')
  final int isPublishPriceForeign;
}
