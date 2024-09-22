import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestFilteredDate {
  const ModelRequestFilteredDate({this.filter});
  final ModelRequestDate? filter;
}

@jsonSerializable
class ModelRequestDate {
  const ModelRequestDate({this.date});
  final ModelDate? date;
}

@jsonSerializable
class ModelDate {
  const ModelDate({this.start, this.end});
  final String? start;
  final String? end;
}
