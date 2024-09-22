import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_branches.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseBranch extends ResponseData {
  const ModelResponseBranch({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelBranch? data;
}
