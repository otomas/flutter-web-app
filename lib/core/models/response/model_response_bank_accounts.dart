import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_balance.dart';
import '../model_district.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseBankAccounts extends ResponseData {

  const ModelResponseBankAccounts({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelBankAccounts>? data;
}

@jsonSerializable
class ModelBankAccounts {

  const ModelBankAccounts({
    required this.id,
    this.bankBranchId,
    this.name,
    this.iban,
    this.accountNumber,
    this.balance,
    this.bankBranch,
  });
  final int id;
  
  @JsonProperty(name: 'bank_branch_id')
  final int? bankBranchId;
  
  final String? name;
  final String? iban;
  
  @JsonProperty(name: 'account_number')
  final String? accountNumber;
  
  final ModelBalance? balance;
  
  @JsonProperty(name: 'bank_branch')
  final ModelBankBranchs? bankBranch;
}

@jsonSerializable
class ModelBankBranchs {

  const ModelBankBranchs({this.id, this.district, this.bankId, this.bank, this.name});
  final int? id;

  @JsonProperty(name: 'bank_id')
  final int? bankId;
  final String? name;
  final ModelBank? bank;
  final ModelDistrict? district;
}

@jsonSerializable
class ModelBank {
  const ModelBank({this.id, this.name});
  final int? id;
  final String? name;
}
