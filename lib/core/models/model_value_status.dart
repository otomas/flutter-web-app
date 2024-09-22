import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelValueStatus {

  const ModelValueStatus({
    this.value,
    this.label,
  });
  final int? value;
  final String? label;
}
