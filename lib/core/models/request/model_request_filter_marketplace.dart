import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestFilterMarketplace {
  const ModelRequestFilterMarketplace({this.sortBy, this.filters});

  @JsonProperty(name: 'sort_by')
  final String? sortBy;

  final ModelFilterMarketplaceRequest? filters;
}

@jsonSerializable
class ModelFilterMarketplaceRequest {
  const ModelFilterMarketplaceRequest({
    this.vehicleBrandId,
    this.vehicleSeriesId,
    this.vehicleModelId,
    this.provinceId,
    this.districtId,
    this.price,
    this.year,
    this.fuelType,
    this.transmissionType,
    this.bodyType,
    this.enginePower,
    this.engineCapacity,
    this.tractionType,
    this.date,
  });

  @JsonProperty(name: 'vehicle_brand_id')
  final int? vehicleBrandId;

  @JsonProperty(name: 'vehicle_series_id')
  final int? vehicleSeriesId;

  @JsonProperty(name: 'vehicle_model_id')
  final int? vehicleModelId;

  @JsonProperty(name: 'province_id')
  final int? provinceId;

  @JsonProperty(name: 'district_id')
  final int? districtId;

  final ModelMinMax? price;

  final ModelMinMax? year;

  @JsonProperty(name: 'fuel_type')
  final List<int>? fuelType;

  @JsonProperty(name: 'transmission_type')
  final List<int>? transmissionType;

  @JsonProperty(name: 'body_type')
  final List<int>? bodyType;

  @JsonProperty(name: 'engine_power')
  final List<String>? enginePower;

  @JsonProperty(name: 'engine_capacity')
  final List<String>? engineCapacity;

  @JsonProperty(name: 'traction_type')
  final List<int>? tractionType;

  final List<String>? date;
}

@jsonSerializable
class ModelMinMax {
  const ModelMinMax({this.min, this.max});

  final String? min;
  final String? max;
}
