import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_base_dropdown.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseVehicleReportChecklist extends ResponseData {
  const ModelResponseVehicleReportChecklist({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelVehicleReportChecklist>? data;
}

@jsonSerializable
class ModelVehicleReportChecklist implements BaseDropdown {
  const ModelVehicleReportChecklist({required this.id, required this.name, required this.isRequired, required this.groupNo});

  final int id;
  final String? name;

  @JsonProperty(name: 'is_required')
  final bool isRequired;

  @JsonProperty(name: 'group_no')
  final int? groupNo;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '';
}
