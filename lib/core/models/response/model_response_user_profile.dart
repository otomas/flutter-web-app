import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_user_profile.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseUserProfile extends ResponseData {
  const ModelResponseUserProfile({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelUserProfile? data;
}
