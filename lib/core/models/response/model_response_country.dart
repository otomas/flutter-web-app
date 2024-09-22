import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_base_dropdown.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseCountryList extends ResponseData {

  const ModelResponseCountryList({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelCountry>? data;
}

@jsonSerializable
class ModelCountry implements BaseDropdown {

  const ModelCountry({
    required this.id,
    this.name,
    this.countryCode,
    this.internetCode,
    this.unCode,
    this.unBumber,
    this.callingCode,
    this.licensePlateCode,
  });
  final int id;
  final String? name;

  @JsonProperty(name: 'country_code')
  final String? countryCode;

  @JsonProperty(name: 'internet_code')
  final String? internetCode;

  @JsonProperty(name: 'un_code')
  final String? unCode;

  @JsonProperty(name: 'un_number')
  final String? unBumber;

  @JsonProperty(name: 'calling_code')
  final String? callingCode;

  @JsonProperty(name: 'license_plate_code')
  final String? licensePlateCode;
  
  @override
  String get dropdownId => id.toString();
  
  @override
  String get dropdownTitle => name ?? '-';
}
