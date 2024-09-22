import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_base_dropdown.dart';
import 'model_neighborhood.dart';

@jsonSerializable
class ModelCustomer implements BaseDropdown  {

  const ModelCustomer({
    required this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.citizenNo,
    this.email,
    this.companyTypeId,
    this.taxOfficeId,
    this.neighborhoodId,
    this.neighborhood,
    this.phoneNumber,
    this.faxNumber,
    this.address,
    this.taxNo,
    this.dateOfBirth,
  });
  final int id;
  final String? title;

  @JsonProperty(name: 'first_name')
  final String? firstName;

  @JsonProperty(name: 'last_name')
  final String? lastName;

  @JsonProperty(name: 'mobile_number')
  final String? mobileNumber;

  @JsonProperty(name: 'citizen_no')
  final String? citizenNo;

  final String? email;

  @JsonProperty(name: 'company_type_id')
  final int? companyTypeId;

  @JsonProperty(name: 'tax_office_id')
  final int? taxOfficeId;

  @JsonProperty(name: 'neighborhood_id')
  final int? neighborhoodId;

  final ModelNeighborhood? neighborhood;

  final String? phoneNumber;

  @JsonProperty(name: 'fax_number')
  final String? faxNumber;

  final String? address;

  @JsonProperty(name: 'tax_no')
  final String? taxNo;

  @JsonProperty(name: 'date_of_birth')
  final DateTime? dateOfBirth;

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}';
  
  @override
  String get dropdownId => id.toString();
  
  @override
  String get dropdownTitle => fullName;

  
}
