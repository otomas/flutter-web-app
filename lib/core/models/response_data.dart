import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ResponseData<T> {

  const ResponseData({
    required this.status,
    this.error,
  });
  final bool status;
  final ModelError? error;
}

class ModelError {

  const ModelError({required this.description, this.fields});
  final String? description;
  final Map<String, String>? fields;
}
