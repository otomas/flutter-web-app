import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelFilterDate {

  const ModelFilterDate({
    this.start,
    this.end,
  });
  final DateTime? start;
  final DateTime? end;
}
