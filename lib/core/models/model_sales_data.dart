import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';

@jsonSerializable
class ModelSalesData {

  ModelSalesData(this.title, this.incomeValue, this.expenseValue);
  final String? title;
  ModelBalance incomeValue;
  ModelBalance expenseValue;
}
