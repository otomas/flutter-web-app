import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseInspectionCompletion extends ResponseData {
  const ModelResponseInspectionCompletion({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelInspectionCompletionResponse? data;
}

@jsonSerializable
class ModelInspectionCompletionResponse {
  const ModelInspectionCompletionResponse({
    required this.upcoming,
    required this.expired,
  });
  final List<ModelInspectionCompletion> upcoming;
  final List<ModelInspectionCompletion> expired;
}

@jsonSerializable
class ModelInspectionCompletion {
  const ModelInspectionCompletion({
    required this.id,
    required this.inspectionEndDate,
    required this.plateNumber,
  });
  final int id;

  @JsonProperty(name: 'inspection_end_date')
  final DateTime inspectionEndDate;

  @JsonProperty(name: 'plate_number')
  final String plateNumber;
}
