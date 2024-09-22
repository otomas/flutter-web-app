import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_base_dropdown.dart';
import 'model_sidebar.dart';

@jsonSerializable
class ModelSideBarId implements BaseDropdown {

  const ModelSideBarId({this.id, this.model});
  final num? id;
  final ModelSideBar? model;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => model?.itemName ?? '-';
}
