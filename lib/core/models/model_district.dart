import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_base_dropdown.dart';
import 'response/model_response_city.dart';

@jsonSerializable
class ModelDistrict implements BaseDropdown {
  const ModelDistrict({
    required this.id,
    required this.provinceId,
    this.name,
    this.province,
  });
  final int id;
  final String? name;

  @JsonProperty(name: 'province_id')
  final int provinceId;

  final ModelCity? province;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}
