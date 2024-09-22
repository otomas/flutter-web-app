import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';

@jsonSerializable
class ModelBalanceTopUp {

  const ModelBalanceTopUp({
    this.id,
    this.autoGalleryId,
    this.payableId,
    this.payableType,
    this.amount,
    this.status,
    this.payable,
  });
  final int? id;
  @JsonProperty(name: 'auto_gallery_id')
  final int? autoGalleryId;
  @JsonProperty(name: 'payable_id')
  final int? payableId;
  @JsonProperty(name: 'payable_type')
  final String? payableType;
  final ModelBalance? amount;
  final ModelBalanceStatus? status;
  final ModelPayable? payable;
}

@jsonSerializable
class ModelBalanceStatus {
  const ModelBalanceStatus({this.value, this.label});
  final int? value;
  final String? label;
}

@jsonSerializable
class ModelPayable {

  const ModelPayable({
    this.id,
    this.bankBranchId,
    this.name,
    this.iban,
    this.accountNumber,
    this.balance,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.type,
  });
  final int? id;

  @JsonProperty(name: 'bank_branch_id')
  final int? bankBranchId;

  final String? name;
  final String? iban;

  @JsonProperty(name: 'account_number')
  final String? accountNumber;

  final ModelBalance? balance;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;

  @JsonProperty(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonProperty(name: 'deleted_at')
  final DateTime? deletedAt;

  final String? type;
}
