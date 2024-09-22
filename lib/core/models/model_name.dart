import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelName {

  const ModelName({
    this.id,
    this.firstName,
    this.lastName,
  });
  final int? id;

  @JsonProperty(name: 'first_name')
  final String? firstName;

  @JsonProperty(name: 'last_name')
  final String? lastName;

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}';
}
