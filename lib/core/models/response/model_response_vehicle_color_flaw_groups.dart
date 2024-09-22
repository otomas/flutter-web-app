import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_base_dropdown.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleColorFlawGroups extends ResponseData {
  const ModelResponseVehicleColorFlawGroups({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleColorFlawGroup>? data;
}

@jsonSerializable
class ModelVehicleColorFlawGroup implements BaseDropdown {
  const ModelVehicleColorFlawGroup({required this.id, required this.name, required this.color, required this.isVisible, required this.isAllSelectable});

  final int id;
  final String? name;
  final String color;

  @JsonProperty(name: 'is_visible')
  final bool isVisible;

  @JsonProperty(name: 'is_all_selectable')
  final bool isAllSelectable;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '';
}
