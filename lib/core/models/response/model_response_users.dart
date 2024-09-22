import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_user_info.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseUsers extends ResponseData {
  const ModelResponseUsers({
    super.status = false,
    super.error,
    this.data,
    this.recordsTotal,
  });
  final int? recordsTotal;
  final List<ModelUserInfo>? data;
}
