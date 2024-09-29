import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../model_advert_owner_type.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseAdvertOwnerType extends ResponseData {
  const ModelResponseAdvertOwnerType({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelAdwertOwnerType>? data;
}
