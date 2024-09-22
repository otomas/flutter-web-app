import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestAddAccountingBook {
  const ModelRequestAddAccountingBook(
    this.accountModel,
    this.accountId,
    this.accountTransactionCategoryId,
    this.transactionDate,
    this.transactionType,
    this.versusType,
    this.versusId,
    this.credit,
    this.debit,
    this.description,
  );

  @JsonProperty(name: 'account_model')
  final String accountModel;

  @JsonProperty(name: 'account_id')
  final num accountId;

  @JsonProperty(name: 'account_transaction_category_id')
  final num accountTransactionCategoryId;

  @JsonProperty(name: 'transaction_date')
  final String transactionDate;

  @JsonProperty(name: 'transaction_type')
  final String transactionType;

  @JsonProperty(name: 'versus_type')
  final String versusType;

  @JsonProperty(name: 'versus_id')
  final num versusId;

  final num credit;
  final num debit;
  final String description;
}
