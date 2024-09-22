import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../response_data.dart';
import 'model_response_bank_accounts.dart';

@jsonSerializable
class ModelREsponseBankAccountInfo extends ResponseData {
  const ModelREsponseBankAccountInfo({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelBankAccounts? data;
}
