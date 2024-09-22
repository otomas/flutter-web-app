import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_neighborhood.dart';
import 'model_pos_devices.dart';

@jsonSerializable
class ModelUserInfo {

  const ModelUserInfo({
    required this.id,
    this.autoGalleryBranchId,
    this.citizenNo,
    this.lastName,
    this.email,
    this.neighborhoodId,
    this.address,
    this.avatar,
    this.dateOfBirth,
    this.firstName,
    this.mobileNo,
    this.autoGalleryBranch,
    this.neighborhood,
    this.dateOfActivity,
    this.dateOfLastLogin,
    this.dateOfLastPasswordChange,
    this.emailVerifiedAt,
    this.mobileNumberVerifiedAt,
    this.autoGallery,
  });
  final int id;
  @JsonProperty(name: 'auto_gallery_branch_id')
  final int? autoGalleryBranchId;

  @JsonProperty(name: 'citizen_no')
  final String? citizenNo;

  @JsonProperty(name: 'first_name')
  final String? firstName;

  @JsonProperty(name: 'last_name')
  final String? lastName;

  @JsonProperty(name: 'mobile_number')
  final String? mobileNo;

  final String? email;

  @JsonProperty(name: 'neighborhood_id')
  final int? neighborhoodId;

  final String? address;

  @JsonProperty(name: 'date_of_birth')
  final DateTime? dateOfBirth;

  @JsonProperty(name: 'date_of_activity')
  final DateTime? dateOfActivity;
  
  @JsonProperty(name: 'date_of_last_login')
  final DateTime? dateOfLastLogin;
  
  @JsonProperty(name: 'date_of_last_password_change')
  final DateTime? dateOfLastPasswordChange;
  
  @JsonProperty(name: 'mobile_number_verified_at')
  final DateTime? mobileNumberVerifiedAt;
  
  @JsonProperty(name: 'email_verified_at')
  final DateTime? emailVerifiedAt;

  final ModelNeighborhood? neighborhood;

  @JsonProperty(name: 'auto_gallery_branch')
  final ModelAutoGalleryBranch? autoGalleryBranch;

  final String? avatar;

  @JsonProperty(name: 'auto_gallery')
  final ModelAutogGallery? autoGallery;

  String get fullName => '$firstName $lastName' ;
}

@jsonSerializable
class ModelAutogGallery {

  const ModelAutogGallery({this.id, this.title});
  final int? id;
  final String? title;
}
