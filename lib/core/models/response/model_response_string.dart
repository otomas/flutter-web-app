import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseString extends ResponseData {

  const ModelResponseString({
    super.status = false,
    super.error,
    this.data,
  });
  final String? data;
}
