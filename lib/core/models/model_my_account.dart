import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelMyAccount {

  const ModelMyAccount({
    required this.isCompMailVerified,
    required this.isMobilePhoneVerified,
    required this.isAuthorizedMailVerified,
    required this.name,
    required this.label,
    required this.establishment,
    required this.compMail,
    required this.authorizedName,
    required this.mobilePhone,
    required this.authorizedMail,
    required this.taxOffice,
    required this.taxNo,
    required this.location,
    required this.region,
    this.isPremium = false,
  });
  final String name;
  final String label;
  final String establishment;
  final String compMail;
  final bool isCompMailVerified;
  final String authorizedName;
  final String mobilePhone;
  final bool isMobilePhoneVerified;
  final String authorizedMail;
  final bool isAuthorizedMailVerified;
  final String taxOffice;
  final String taxNo;
  final String location;
  final String region;
  final bool isPremium;
}
