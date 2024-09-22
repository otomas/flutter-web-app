import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_base_dropdown.dart';

import 'response/model_response_country.dart';

@jsonSerializable
class ModelNeighborhood implements BaseDropdown {

  const ModelNeighborhood({this.id, this.name, this.districtId, this.district, this.postalCode});
  final int? id;
  final String? name;

  @JsonProperty(name: 'district_id')
  final int? districtId;

  @JsonProperty(name: 'postal_code')
  final String? postalCode;

  final ModelBranchDistrict? district;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}

@jsonSerializable
class ModelBranchDistrict {

  const ModelBranchDistrict({this.id, this.name, this.province});
  final int? id;
  final String? name;
  final ModelProvince? province;
}

@jsonSerializable
class ModelProvince {

  const ModelProvince({this.id, this.name, this.regionId, this.region});
  final int? id;
  final String? name;
  @JsonProperty(name: 'region_id')
  final int? regionId;
  final ModelRegion? region;
}

@jsonSerializable
class ModelRegion {

  const ModelRegion({this.id, this.name, this.countryId, this.country});
  final int? id;
  final String? name;
  @JsonProperty(name: 'country_id')
  final int? countryId;
  final ModelCountry? country;
}
