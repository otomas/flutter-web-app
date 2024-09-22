import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'model_address.dart';
import 'model_company.dart';

@jsonSerializable
class ModelUserProfile {

  const ModelUserProfile({
    this.name,
    this.surname,
    this.email,
    this.mobileNumber,
    this.address,
    this.company,
  });
  final String? name;
  final String? surname;
  final String? email;

  @JsonProperty(name: 'mobile_number')
  final String? mobileNumber;

  final ModelAddress? address;
  final ModelCompany? company;
}
