import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../../enums/enum_api.dart';
import '../model_balance.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleStatus extends ResponseData {
  const ModelResponseVehicleStatus({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelVehicleStatus? data;
}

@jsonSerializable
class ModelVehicleStatus {
  ModelVehicleStatus({
    required this.status,
    required this.plateNumber,
    this.isPublishPriceDomestic = false,
    this.isPublishPriceForeign = false,
    this.priceDomestic,
    this.priceForeign,
    this.price,
  });

  final VehicleStatus? status;

  @JsonProperty(name: 'plate_number')
  final String plateNumber;

  @JsonProperty(name: 'is_publish_price_domestic', defaultValue: false)
  bool isPublishPriceDomestic;

  @JsonProperty(name: 'is_publish_price_foreign', defaultValue: false)
  bool isPublishPriceForeign;

  @JsonProperty(name: 'price_domestic')
  final ModelBalance? priceDomestic;

  @JsonProperty(name: 'price_foreign')
  final ModelBalance? priceForeign;

  final ModelBalance? price;
}
