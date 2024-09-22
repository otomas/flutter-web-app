import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'model_base_dropdown.dart';

@jsonSerializable
class ModelDropdown implements BaseDropdown {

  const ModelDropdown({required this.id, required this.title, this.parentId, this.text});
  final int id;
  final String title;
  final int? parentId;
  final String? text;

  @override
  String get dropdownId => id.toString();
  @override
  String get dropdownTitle => title;
}
