import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';
import 'model_buy_sell_chart.dart';
import 'model_filter_date.dart';

@jsonSerializable
class ModelTurnover {

  const ModelTurnover({this.filterDate, this.turnover});
  final ModelFilterDate? filterDate;
  final List<ModelTurnoverData>? turnover;
}

@jsonSerializable
class ModelTurnoverData {

  const ModelTurnoverData({this.name,this.chart, this.label, this.type, this.items, this.totalCredit, this.totalDebit, this.grandTotal});
  final String? name;
  final String? type;
  final String? label;
  final List<ModelTurnoverItem>? items;

  @JsonProperty(name: 'total_credit')
  final ModelBalance? totalCredit;

  @JsonProperty(name: 'total_debit')
  final ModelBalance? totalDebit;

  @JsonProperty(name: 'grand_total')
  final ModelBalance? grandTotal;

  final ModelBuySellChart? chart;

}

@jsonSerializable
class ModelTurnoverItem {

  const ModelTurnoverItem({
    required this.id,
    this.name,
    this.autoGalleryId,
    this.credit,
    this.debit,
    this.total,
  });
  final int id;
  final String? name;

  @JsonProperty(name: 'auto_gallery_id')
  final int? autoGalleryId;

  final ModelBalance? credit;
  final ModelBalance? debit;
  final ModelBalance? total;
}
