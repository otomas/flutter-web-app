import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelCompany {

  const ModelCompany({
    this.title,
    this.dateOfIncorporation,
    this.email,
    this.ownerName,
    this.ownerSurname,
    this.mobileNumber,
    this.taxOffice,
    this.taxNumber,
  });
  final String? title;

  @JsonProperty(name: 'date_of_incorporation')
  final DateTime? dateOfIncorporation;

  final String? email;

  @JsonProperty(name: 'owner_name')
  final String? ownerName;

  @JsonProperty(name: 'mobile_number')
  final String? mobileNumber;

  @JsonProperty(name: 'owner_surname')
  final String? ownerSurname;

  @JsonProperty(name: 'tax_office')
  final String? taxOffice;

  @JsonProperty(name: 'tax_number')
  final String? taxNumber;

  String get ownerFullName => '${ownerName ?? ''} ${ownerSurname ?? ''}';
}
