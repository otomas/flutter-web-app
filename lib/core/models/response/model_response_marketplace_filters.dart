import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_value_label.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseMarketPlaceFilters extends ResponseData {
  const ModelResponseMarketPlaceFilters({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelMarketplaceFilterResponse? data;
}

@jsonSerializable
class ModelMarketplaceFilterResponse {
  const ModelMarketplaceFilterResponse({this.sortBy, this.filters});

  @JsonProperty(name: 'sort_by')
  final List<ModelValueLabel>? sortBy;

  final ModelMarketplaceFilter? filters;
}

@jsonSerializable
class ModelMarketplaceFilter {
  const ModelMarketplaceFilter({
    required this.enginePower,
    required this.engineCapacity,
    required this.date,
  });

  @JsonProperty(name: 'engine_power')
  final List<ModelValueLabel>? enginePower;

  @JsonProperty(name: 'engine_capacity')
  final List<ModelValueLabel>? engineCapacity;

  final List<ModelValueLabel>? date;
}
