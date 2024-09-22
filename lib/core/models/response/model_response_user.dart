import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_user_info.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseUser extends ResponseData {
  const ModelResponseUser({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelUserInfo? data;
}
