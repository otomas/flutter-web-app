import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelBuySellChart {
  const ModelBuySellChart({
    this.datasets,
    this.labels,
  });
  final List<ModelSellChartDataSet>? datasets;
  final List<String>? labels;
}

@jsonSerializable
class ModelSellChartDataSet {
  const ModelSellChartDataSet({
    this.name,
    this.type,
    this.values,
    this.undefinedColor,
  });
  final String? name;
  final String? type;
  final List<num>? values;
  final String? undefinedColor;
}
