import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'response/model_response_vehicle_color_flaw_groups.dart';
import 'response/model_response_vehicle_report_checklist.dart';

@jsonSerializable
class ModelVehicleExperties {
  const ModelVehicleExperties({
    required this.colorReportChecklistId,
    required this.colorFlawGroupId,
    required this.colorFlawGroup,
    required this.colorReportChecklist,
    this.isScratch,
    this.isDent,
  });

  @JsonProperty(name: 'color_report_checklist_id')
  final int colorReportChecklistId;

  @JsonProperty(name: 'color_flaw_group_id')
  final int colorFlawGroupId;

  @JsonProperty(name: 'is_dent')
  final int? isDent;

  @JsonProperty(name: 'is_scratch')
  final int? isScratch;

  @JsonProperty(name: 'color_flaw_group')
  final ModelVehicleColorFlawGroup colorFlawGroup;

  @JsonProperty(name: 'color_report_checklist')
  final ModelVehicleReportChecklist colorReportChecklist;
}
