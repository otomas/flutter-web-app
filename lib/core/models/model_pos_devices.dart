import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';
import 'model_base_dropdown.dart';
import 'model_neighborhood.dart';

@jsonSerializable
class ModelBranchPosDevice {
  const ModelBranchPosDevice({
    required this.id,
    this.autoGalleryBankAccountId,
    this.autoGalleryBranchId,
    this.branch,
    this.account,
    this.name,
    this.balance,
  });
  @JsonProperty(name: 'auto_gallery_branch')
  final ModelAutoGalleryBranch? branch;

  @JsonProperty(name: 'auto_gallery_bank_account')
  final ModelAutoGalleryBankAccount? account;

  final String? name;
  final ModelBalance? balance;
  final int id;
  @JsonProperty(name: 'auto_gallery_bank_account_id')
  final int? autoGalleryBankAccountId;
  @JsonProperty(name: 'auto_gallery_branch_id')
  final int? autoGalleryBranchId;
}

@jsonSerializable
class ModelAutoGalleryBranch implements BaseDropdown {
  const ModelAutoGalleryBranch({
    required this.id,
    this.bankId,
    this.districtId,
    this.code,
    this.phoneNumber,
    this.faxNumber,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.neighborhood,
    this.autoGallery,
  });
  final int id;

  @JsonProperty(name: 'bank_id')
  final int? bankId;

  final String? name;
  final String? code;

  @JsonProperty(name: 'phone_number')
  final String? phoneNumber;

  @JsonProperty(name: 'district_id')
  final int? districtId;

  @JsonProperty(name: 'fax_number')
  final String? faxNumber;

  final String? address;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;
  @JsonProperty(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonProperty(name: 'deleted_at')
  final DateTime? deletedAt;

  final ModelNeighborhood? neighborhood;

  @JsonProperty(name: 'auto_gallery')
  final ModelAutoGallery? autoGallery;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}

@jsonSerializable
class ModelAutoGalleryBankAccount implements BaseDropdown {
  const ModelAutoGalleryBankAccount({required this.id, this.name});
  final int id;
  final String? name;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}

@jsonSerializable
class ModelAutoGallery implements BaseDropdown {
  const ModelAutoGallery(
    this.email,
    this.phone,
    this.id,
    this.name,
  );

  final int? id;
  final String? name;
  final String? email;

  @JsonProperty(name: 'phone_number')
  final String? phone;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}

@jsonSerializable
class ModelAutoGalleryWithTitle implements BaseDropdown {
  const ModelAutoGalleryWithTitle(
    this.email,
    this.phone,
    this.id,
    this.title,
    this.accountType,
  );

  final int? id;
  final String? title;
  final String? email;

  @JsonProperty(name: 'account_type')
  final ModelAutoGalleryAccountType? accountType;

  @JsonProperty(name: 'phone_number')
  final String? phone;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => title ?? '-';
}

@jsonSerializable
class ModelAutoGalleryAccountType implements BaseDropdown {
  const ModelAutoGalleryAccountType({required this.id, this.name});
  final int id;
  final String? name;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}
