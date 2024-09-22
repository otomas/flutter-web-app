import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/enums/enum_app.dart';
import '../../core/models/model_balance.dart';
import '../../core/models/model_buy_sell_chart.dart';
import '../../core/models/model_sales_data.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widget_graph.dart';

class WidgetBuySellChart extends WidgetBase<VmWidgetBuySellChart> {
  const WidgetBuySellChart({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetBuySellChart createViewModel(BuildContext context) => VmWidgetBuySellChart(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetBuySellChart viewModel) => buildWidget(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetBuySellChart viewModel) => viewModel.isLoading()
      ? const SizedBox(width: double.infinity, height: 300)
      : WidgetCustomGraph(
          data: viewModel.sellData,
          xValueMapper: (data) => data.title ?? '',
          yValueMapper: (data) => (data.incomeValue.amount ?? 0).toDouble(),
          seconYValueMapper: (data) => data.expenseValue.amount?.toDouble() ?? 0,
          buyLabelText: viewModel.sellTitles.isNotEmpty ? viewModel.sellTitles.first : '',
          sellLabelText: viewModel.sellTitles.length > 1 ? viewModel.sellTitles[1] : '',
          header: 'Alıcı ve Satıcı Grafiğiniz',
          firstBarColor: R.themeColor.primary,
          secondBarColor: R.themeColor.info,
          borderColor: R.themeColor.border,
        );
}

class VmWidgetBuySellChart extends ViewModelBase {
  VmWidgetBuySellChart(this.serviceApi) {
    init();
  }

  final ServiceApi serviceApi;

  ModelBuySellChart? data;

  List<String> sellTitles = [];
  List<ModelSalesData> sellData = [];

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getBuySellChart().then(
      (response) {
        data = response.data;
        if (data != null) {
          final labels = <String>[];
          final incomings = <ModelBalance>[];
          final expenseValues = <ModelBalance>[];
          data!.labels?.forEach(labels.add);
          if (data!.datasets != null && data!.datasets!.isNotEmpty && data!.datasets!.length > 1) {
            sellTitles.add(data!.datasets!.first.name ?? '');
            data!.datasets!.first.values?.forEach((element) {
              incomings.add(ModelBalance(amount: element));
            });
            sellTitles.add(data!.datasets![1].name ?? '');
            data!.datasets![1].values?.forEach((element) {
              expenseValues.add(ModelBalance(amount: element));
            });
          }
          if (labels.length == incomings.length && labels.length == expenseValues.length) {
            for (var i = 0; i < labels.length; i++) {
              sellData.add(ModelSalesData(labels[i], incomings[i], expenseValues[i]));
            }
          }
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }
}
