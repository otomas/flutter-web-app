import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'model_base_dropdown.dart';

@jsonSerializable
class ModelValueLabel extends BaseDropdown {
  ModelValueLabel({this.value, this.label});
  final String? value;
  final String? label;

  @override
  String get dropdownId => value ?? '';

  @override
  String get dropdownTitle => label ?? '';
}
