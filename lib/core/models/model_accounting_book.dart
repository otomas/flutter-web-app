import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';
import 'model_buy_sell_chart.dart';
import 'model_turnover.dart';

@jsonSerializable
class ModelAccountingBook {

  const ModelAccountingBook({this.accountsReport, this.categoryReport});
  @JsonProperty(name: 'category_report')
  final ModelCategoryReport? categoryReport;

  @JsonProperty(name: 'accounts_report')
  final List<ModelTurnoverData>? accountsReport;
}

@jsonSerializable
class ModelCategoryReport {

  const ModelCategoryReport({this.grandTotal, this.items, this.totalCredit, this.totalDebit, this.chart, this.categoryName});
  final List<ModelCategoryItem>? items;

  @JsonProperty(name: 'total_debit')
  final ModelBalance? totalDebit;

  @JsonProperty(name: 'total_credit')
  final ModelBalance? totalCredit;

  @JsonProperty(name: 'grand_total')
  final ModelBalance? grandTotal;

  @JsonProperty(name: 'category_name')
  final String? categoryName;

  final ModelBuySellChart? chart;
}

@jsonSerializable
class ModelCategoryItem {

  const ModelCategoryItem({
    this.categoryName,
    this.credit,
    this.debit,
    this.total,
  });
  @JsonProperty(name: 'category_name')
  final String? categoryName;

  final ModelBalance? credit;
  final ModelBalance? debit;
  final ModelBalance? total;
}
