import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_base_dropdown.dart';

@jsonSerializable
class ModelValue implements BaseDropdown {
  const ModelValue({this.id, this.name});
  final int? id;
  final String? name;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}
