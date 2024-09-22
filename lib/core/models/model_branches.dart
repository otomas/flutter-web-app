import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'model_balance.dart';
import 'model_base_dropdown.dart';
import 'model_neighborhood.dart';

@jsonSerializable
class ModelBranch implements BaseDropdown {

  const ModelBranch({
    required this.id,
    required this.licenceExpireDate, this.uuid,
    this.autoGalleryId,
    this.neighborhoodId,
    this.no,
    this.name,
    this.address,
    this.phone,
    this.balance,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.neighborhood,
  });
  final int id;
  final String? uuid;
  @JsonProperty(name: 'auto_gallery_id')
  final int? autoGalleryId;
  @JsonProperty(name: 'neighborhood_id')
  final int? neighborhoodId;
  final int? no;
  final String? name;
  final String? address;

  @JsonProperty(name: 'phone_number')
  final String? phone;

  final ModelBalance? balance;

  @JsonProperty(name: 'license_expire_date')
  final DateTime licenceExpireDate;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;

  @JsonProperty(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonProperty(name: 'deleted_at')
  final DateTime? deletedAt;

  final ModelNeighborhood? neighborhood;
  
  @override
  String get dropdownId => id.toString();
  
  @override
  String get dropdownTitle => name ?? '';
}
