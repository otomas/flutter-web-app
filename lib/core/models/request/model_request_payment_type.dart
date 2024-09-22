import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestPaymentType {

  const ModelRequestPaymentType({
    required this.paymentTypeId,
    required this.amount, this.branchPosDeviceId,
    this.bankAccountId,
  });
  @JsonProperty(name: 'payment_type_id')
  final int paymentTypeId;

  @JsonProperty(name: 'branch_pos_device_id')
  final int? branchPosDeviceId;

  @JsonProperty(name: 'bank_account_id')
  final int? bankAccountId;

  final int amount;
}
