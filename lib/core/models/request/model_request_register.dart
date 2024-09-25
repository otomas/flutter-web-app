import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestRegister {
  const ModelRequestRegister({
    required this.companyTypeId,
    required this.ownerCitizenNo,
    required this.ownerDateOfBirth,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.mobileNumber,
    required this.email,
    required this.neighborhoodId,
    required this.address,
    required this.title,
    required this.phoneNumber,
    required this.accountingEmail,
    required this.password,
    required this.passwordConfirmation,
    this.dateOfIncorporation,
    this.taxOfficeId,
    this.taxNo,
    this.faxNumber,
  });

  @JsonProperty(name: 'company_type_id')
  final int companyTypeId;

  @JsonProperty(name: 'ownerCitizenNo')
  final String ownerCitizenNo;

  @JsonProperty(name: 'owner_date_of_birth')
  final DateTime ownerDateOfBirth;

  @JsonProperty(name: 'owner_first_name')
  final String ownerFirstName;

  @JsonProperty(name: 'owner_last_name')
  final String ownerLastName;

  @JsonProperty(name: 'mobile_number')
  final String mobileNumber;

  final String email;

  @JsonProperty(name: 'neighborhoodId')
  final int neighborhoodId;

  final String address;
  final String? title;

  @JsonProperty(name: 'date_of_incorporation')
  final DateTime? dateOfIncorporation;

  @JsonProperty(name: 'tax_office_id')
  final int? taxOfficeId;

  @JsonProperty(name: 'tax_no')
  final String? taxNo;

  @JsonProperty(name: 'phone_number')
  final String phoneNumber;

  @JsonProperty(name: 'fax_number')
  final String? faxNumber;

  @JsonProperty(name: 'accounting_email')
  final String accountingEmail;
  final String password;

  @JsonProperty(name: 'password_confirmation')
  final String passwordConfirmation;
}
