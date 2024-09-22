import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseInsuranceCompletion extends ResponseData {
  const ModelResponseInsuranceCompletion({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelInsuranceCompletionResponse? data;
}

@jsonSerializable
class ModelInsuranceCompletionResponse {
  const ModelInsuranceCompletionResponse({
    required this.upcoming,
    required this.expired,
  });
  final List<ModelInsuranceCompletion> upcoming;
  final List<ModelInsuranceCompletion> expired;
}

@jsonSerializable
class ModelInsuranceCompletion {
  const ModelInsuranceCompletion({
    required this.id,
    required this.insuranceEndDate,
    required this.plateNumber,
  });
  final int id;

  @JsonProperty(name: 'insurance_end_date')
  final DateTime insuranceEndDate;

  @JsonProperty(name: 'plate_number')
  final String plateNumber;
}
