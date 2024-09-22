import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_num.dart';
import '../../core/models/model_finance.dart';
import '../../core/models/response/model_response_till_report.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_app.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widgets_text.dart';

class WidgetTillReport extends WidgetBase<VmWidgetTillReport> {
  const WidgetTillReport({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetTillReport createViewModel(BuildContext context) => VmWidgetTillReport(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetTillReport viewModel) => buildWidget(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetTillReport viewModel) => viewModel.isLoading()
      ? const SizedBox(width: double.infinity, height: 200)
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBasic(
              text: 'Finansal Genel Bakış',
              color: R.themeColor.smoke,
              fontFamily: R.fonts.displayBold,
              fontSize: 16,
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: isWeb(context) ? WrapAlignment.start : WrapAlignment.center,
              children: List.generate(
                viewModel.financeData.length,
                (index) {
                  final item = viewModel.financeData[index];
                  return SizedBox(
                    width: (fragmentWidth(context) - 90) / (isWeb(context) ? 3 : 2),
                    child: InkWell(
                      splashColor: R.color.transparent,
                      focusColor: R.color.transparent,
                      highlightColor: R.color.transparent,
                      onTap: () {
                        if (item.routeIndex != null) {
                          di<ServiceApp>(context).tabsRouter.setActiveIndex(item.routeIndex!);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: (isWeb(context) ? index > 2 : index == viewModel.financeData.length - 1)
                                ? BorderSide.none
                                : BorderSide(color: R.themeColor.border),
                            left: index == 0 || (isWeb(context) ? index % 3 == 0 : index.isEven) ? BorderSide.none : BorderSide(color: R.themeColor.border),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: isWeb(context) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                          children: [
                            TextBasic(text: item.title, color: R.themeColor.smoke, fontFamily: R.fonts.displayMedium, fontSize: 12),
                            const SizedBox(height: 6),
                            TextBasic(
                              text: item.value.formatPrice(),
                              color: item.isTotal ? R.color.river : R.themeColor.secondary,
                              fontFamily: R.fonts.displayBold,
                              fontSize: 18,
                              textAlign: isWeb(context) ? TextAlign.start : TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            TextBasic(text: item.actionButtonText, color: R.themeColor.primary, fontSize: 12),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
}

class VmWidgetTillReport extends ViewModelBase {
  VmWidgetTillReport(this.serviceApi) {
    init();
  }

  final ServiceApi serviceApi;

  ModelTillReport? data;
  List<ModelFinance> financeData = [];

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getTillReport().then(
      (response) {
        data = response.data;
        if (data != null) {
          financeData.addAll([
            if (data!.bank?.amount != null)
              ModelFinance(
                title: 'Banka Toplam',
                value: data!.bank!.amount!,
                currency: NumberFormat.currency(symbol: data!.bank!.symbol).format(data!.bank!.amount),
                actionButtonText: 'Bankaları Görüntüle',
                isTotal: false,
                routeIndex: 12,
              ),
            if (data!.posDevice?.amount != null)
              ModelFinance(
                title: 'Pos Toplam',
                value: data!.posDevice!.amount!,
                currency: NumberFormat.currency(symbol: data!.posDevice!.symbol).format(data!.bank!.amount),
                actionButtonText: 'Posları Görüntüle',
                isTotal: false,
                routeIndex: 15,
              ),
            if (data!.branch?.amount != null)
              ModelFinance(
                title: 'Şube Toplam',
                value: data!.branch!.amount!,
                currency: NumberFormat.currency(symbol: data!.branch!.symbol).format(data!.bank!.amount),
                actionButtonText: 'Şubeleri Görüntüle',
                isTotal: false,
                routeIndex: 19,
              ),
            if (data!.vehicle?.amount != null)
              ModelFinance(
                title: 'Araç Toplam',
                value: data!.vehicle!.amount!,
                currency: NumberFormat.currency(symbol: data!.vehicle!.symbol).format(data!.bank!.amount),
                actionButtonText: 'Araçları Görüntüle',
                isTotal: false,
                routeIndex: 4,
              ),
            if (data!.balance?.amount != null)
              ModelFinance(
                title: 'Tüm Kasalar',
                value: data!.balance!.amount!,
                currency: NumberFormat.currency(symbol: data!.balance!.symbol).format(data!.bank!.amount),
                actionButtonText: 'Tümünü Görüntüle',
                isTotal: true,
                routeIndex: 14,
              ),
          ]);
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }
}
