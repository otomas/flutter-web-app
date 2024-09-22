import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_base_dropdown.dart';
import '../model_neighborhood.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseCityList extends ResponseData {

  const ModelResponseCityList({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelCity>? data;
}

@jsonSerializable
class ModelCity implements BaseDropdown {

  const ModelCity({
    required this.id,
    required this.regionId, this.name,
    this.region,
    this.licensePlateCode,
  });
  final int id;
  final String? name;

  @JsonProperty(name: 'region_id')
  final int regionId;

  @JsonProperty(name: 'license_plate_code')
  final int? licensePlateCode;

  final ModelRegion? region;
  
  @override
  String get dropdownId => id.toString();
  
  @override
  String get dropdownTitle => name ?? '-';
}
