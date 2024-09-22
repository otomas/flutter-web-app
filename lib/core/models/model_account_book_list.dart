import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';
import 'response/model_transaction_categories.dart';

@jsonSerializable
class ModelAccountBookList {

  const ModelAccountBookList(
      {required this.id, this.accountTransactionCategory,
      this.accountTransactionCategoryId,
      this.accountTransactionTypeId,
      this.amount,
      this.autoGalleryBankAccountId,
      this.balance,
      this.categoryName,
      this.causer,
      this.createdAt,
      this.credit,
      this.debit,
      this.description,
      this.sourceId,
      this.transactionDate,
      this.transactionType,
      this.updatedAt,});
  final num id;

  @JsonProperty(name: 'auto_gallery_bank_account_id')
  final num? autoGalleryBankAccountId;

  @JsonProperty(name: 'account_transaction_type_id')
  final num? accountTransactionTypeId;

  @JsonProperty(name: 'account_transaction_category_id')
  final num? accountTransactionCategoryId;

  @JsonProperty(name: 'source_id')
  final num? sourceId;

  final num? credit;
  final num? debit;

  final ModelBalance? balance;

  final ModelBalance? amount;

  @JsonProperty(name: 'category_name')
  final String? categoryName;

  final ModelDescription? description;

  @JsonProperty(name: 'created_at')
  final DateTime? createdAt;

  @JsonProperty(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonProperty(name: 'transaction_date')
  final DateTime? transactionDate;

  @JsonProperty(name: 'account_transaction_category')
  final ModelTransactionCategories? accountTransactionCategory;

  final String? causer;

  @JsonProperty(name: 'transaction_type')
  final String? transactionType;
}

@jsonSerializable
class ModelDescription {

  const ModelDescription({this.versus, this.category, this.description});
  final String? versus;
  final String? category;
  final String? description;
}
