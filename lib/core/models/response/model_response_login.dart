import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_balance.dart';
import '../model_company.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseLogin extends ResponseData {
  const ModelResponseLogin({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelToken? data;
}

@jsonSerializable
class ModelToken {
  const ModelToken({
    required this.id,
    required this.tokenType,
    required this.expiresIn,
    required this.accessToken,
    required this.refreshToken,
    required this.isVerifiedEmail,
    required this.isVerifiedPhone,
    required this.isChangePassword,
    this.autoGalleryId,
    this.autoGalleryBranchId,
    this.neighborhoodId,
    this.citizenNo,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.address,
    this.balance,
    this.dateOfBirth,
    this.settings,
    this.mobileNumberVerifiedAt,
    this.emailVerifiedAt,
    this.dateOfActivity,
    this.dateOfLastLogin,
    this.dateOfLastPasswordChange,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.company,
  });
  final int id;

  @JsonProperty(name: 'auto_gallery_id')
  final int? autoGalleryId;

  @JsonProperty(name: 'auto_gallery_branch_id')
  final int? autoGalleryBranchId;

  @JsonProperty(name: 'neighborhood_id')
  final int? neighborhoodId;

  @JsonProperty(name: 'citizen_no')
  final String? citizenNo;

  @JsonProperty(name: 'first_name')
  final String? firstName;

  @JsonProperty(name: 'last_name')
  final String? lastName;

  @JsonProperty(name: 'mobile_number')
  final String? mobileNumber;

  final String? email;
  final String? address;
  final ModelBalance? balance;

  @JsonProperty(name: 'date_of_birth')
  final String? dateOfBirth;

  final String? settings;

  @JsonProperty(name: 'mobile_number_verified_at')
  final DateTime? mobileNumberVerifiedAt;

  @JsonProperty(name: 'email_verified_at')
  final DateTime? emailVerifiedAt;

  @JsonProperty(name: 'date_of_activity')
  final DateTime? dateOfActivity;

  @JsonProperty(name: 'date_of_last_login')
  final DateTime? dateOfLastLogin;

  @JsonProperty(name: 'date_of_last_password_change')
  final DateTime? dateOfLastPasswordChange;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;

  @JsonProperty(name: 'created_at')
  final DateTime? updatedAt;

  @JsonProperty(name: 'deleted_at')
  final DateTime? deletedAt;

  final ModelCompany? company;

  @JsonProperty(name: 'token_type')
  final String? tokenType;

  @JsonProperty(name: 'expires_in')
  final int expiresIn;

  @JsonProperty(name: 'access_token')
  final String? accessToken;

  @JsonProperty(name: 'refresh_token')
  final String? refreshToken;

  @JsonProperty(name: 'is_verified_email')
  final bool? isVerifiedEmail;
 
  @JsonProperty(name: 'is_verified_phone')
  final bool? isVerifiedPhone;

  @JsonProperty(name: 'is_change_password')
  final bool? isChangePassword;

  String get fullName => '$firstName $lastName';
}
