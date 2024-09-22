import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_branches.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseBranches extends ResponseData {
  const ModelResponseBranches({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelBranch>? data;
}
