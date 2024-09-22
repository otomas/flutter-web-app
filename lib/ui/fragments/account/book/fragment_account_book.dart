// ignore_for_file: cascade_invocations

import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/extensions/extension_date.dart';
import '../../../../core/extensions/extension_num.dart';
import '../../../../core/models/model_accounting_book.dart';
import '../../../../core/models/model_alert_dialog.dart';
import '../../../../core/models/model_balance.dart';
import '../../../../core/models/model_sales_data.dart';
import '../../../../core/models/model_sidebar.dart';
import '../../../../core/models/model_turnover.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/services/service_route.dart';
import '../../../../core/utils/alert_utils.dart';
import '../../../base/base_view.dart';
import '../../../bs/bs_accounting_report.dart';
import '../../../widgets/activity_indicator.dart';
import '../../../widgets/widget_account_book.dart';
import '../../../widgets/widget_account_book_detail.dart';
import '../../../widgets/widget_button.dart';
import '../../../widgets/widget_dropdown.dart';
import '../../../widgets/widget_graph.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_textfield.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_account_book.dart';

@RoutePage()
class FragmentAccountBook extends StatefulWidget {
  const FragmentAccountBook({super.key});

  @override
  State<FragmentAccountBook> createState() => _FragmentAccountBookState();
}

class _FragmentAccountBookState extends WidgetBaseStatefull<FragmentAccountBook, VmFragmentAccountBook> {
  bool isExpanded = false;
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentAccountBook createViewModel(BuildContext context) => VmFragmentAccountBook(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentAccountBook viewModel) => const Center(child: TextBasic(text: 'book'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentAccountBook viewModel) => _getBodyWeb(context, viewModel);

  Widget _getBodyWeb(BuildContext context, VmFragmentAccountBook viewModel) => ScrollWithNoGlowWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: TextBasic(text: R.string.accountBook, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _getBodyView(context, viewModel),
          ],
        ),
      );

  Widget _getBodyView(BuildContext context, VmFragmentAccountBook viewModel) => Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _sideBarWidget(context, viewModel)),
            const SizedBox(width: 20),
            Expanded(
              flex: 7,
              child: viewModel.selectedSideBar == null ? _getNotSelectedWidget(context, viewModel) : _getSelectedWidget(context, viewModel),
            ),
            const SizedBox(width: 20),
          ],
        ),
      );

  Widget _getSelectedWidget(BuildContext context, VmFragmentAccountBook viewModel) => Column(
        children: [
          _getSelectedDropDownWidget(context, viewModel),
          const SizedBox(height: 20),
          _getSelectedAccountBookWidget(context, viewModel),
          const SizedBox(height: 20),
        ],
      );

  Widget _getNotSelectedWidget(BuildContext context, VmFragmentAccountBook viewModel) => Column(
        children: [
          _getDropdownWidget(context, viewModel),
          const SizedBox(height: 20),
          _getAccountsReport(context, viewModel),
          const SizedBox(height: 20),
        ],
      );

  Widget _sideBarWidget(BuildContext context, VmFragmentAccountBook viewModel) => Column(
        children: [
          _getSearchField(context, viewModel),
          const SizedBox(height: 10),
          Column(
            children: viewModel.sideBarList.entries
                .map(
                  (entry) => Column(
                    children: [
                      _getSideBarContainer(context, viewModel, entry.value, entry.key),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      );

  Widget _getSearchField(BuildContext context, VmFragmentAccountBook viewModel) => TextFieldBasic(
        controller: viewModel.searchController,
        bgColor: R.color.transparent,
        fillColor: R.color.transparent,
        hintText: R.string.search,
        suffixIcon: viewModel.isLoadingPagination ? IOSIndicator(color: R.themeColor.secondary) : Icon(Icons.search, color: R.themeColor.secondary),
      );

  Widget _getAccountsReport(BuildContext context, VmFragmentAccountBook viewModel) => Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: (viewModel.selectedBankAccount == null)
                ? ListView.builder(
                    itemCount: viewModel.data?.accountsReport?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final item = viewModel.data?.accountsReport?[index];
                      return WidgetAccountBook(
                        title: item?.name ?? '',
                        subTitle: item?.label ?? '',
                        data: _getChart(context, viewModel, item),
                        table: item?.items,
                      );
                    },
                  )
                : WidgetAccountBook(
                    title: 'Gelir Gider Trafiğiniz',
                    subTitle: 'Toplam',
                    data: _getSelectedCategoryChart(
                      context,
                      viewModel,
                      viewModel.data?.categoryReport,
                    ),
                  ),
          ),
        ],
      );

  Widget _getBankAccountSelection(BuildContext context, VmFragmentAccountBook viewModel) => DropdownBasic(
        key: UniqueKey(),
        title: R.string.accountSelection,
        hint: 'Seçiniz',
        // ignore: discarded_futures
        items: viewModel.sideBarListData,
        selectedItem: viewModel.selectedBankAccount,
        hasError: viewModel.detectFieldError && viewModel.selectedBankAccount == null,
        errorLabel: R.string.pleaseSelect,
        onChanged: viewModel.setSelectedBankAccount,
      );

  Widget _getStartDatePicker(BuildContext context, VmFragmentAccountBook viewModel) => GestureDetector(
        onTap: () async {
          await showCustomDatePicker(
            context,
            initial: viewModel.startDate,
            min: DateTime.now().add(const Duration(days: 365 * -10)),
            max: DateTime.now(),
            onConfirm: (date, _) {
              setState(() {
                if (viewModel.endDate != null && date.isAfter(viewModel.endDate!)) {
                  showPlatformAlert(
                    context,
                    ModelAlertDialog(
                      title: 'Hata',
                      dialogType: DialogTypes.error,
                      description: 'Başlangıç tarihi bitiş tarihinden büyük olamaz.',
                      isDismissible: false,
                      onPressedButton: () {
                        exit(0);
                      },
                    ),
                  );
                  return;
                }
                viewModel.startDate = date;
                viewModel.startDateController.text = date.dayMonthNameAndYear();
              });
            },
          );
        },
        child: TextFieldBasic(
          title: viewModel.selectedSideBar == null ? 'Başlangıç Tarihi' : null,
          hintText: 'Başlangıç Tarihi Seçiniz',
          controller: viewModel.startDateController,
          suffixIcon: Icon(Icons.date_range, color: R.themeColor.primary),
          enabled: false,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('start_date'),
          errorLabel: viewModel.getErrorMsg('start_date'),
        ),
      );

  Widget _getEndDatePicker(BuildContext context, VmFragmentAccountBook viewModel) => GestureDetector(
        onTap: () async {
          await showCustomDatePicker(
            context,
            initial: viewModel.endDate,
            min: DateTime.now().add(const Duration(days: 365 * -10)),
            max: DateTime.now(),
            onConfirm: (date, _) {
              setState(() {
                if (viewModel.startDate != null && date.isBefore(viewModel.startDate!)) {
                  showPlatformAlert(
                    context,
                    ModelAlertDialog(
                      dialogType: DialogTypes.error,
                      title: 'Hata',
                      description: 'Bitiş tarihi başlangıç tarihinden küçük olamaz.',
                      isDismissible: false,
                      onPressedButton: () {
                        exit(0);
                      },
                    ),
                  );
                  return;
                }
                viewModel.endDate = date;
                viewModel.endDateController.text = date.dayMonthNameAndYear();
              });
            },
          );
        },
        child: TextFieldBasic(
          title: viewModel.selectedSideBar == null ? 'Bitiş Tarihi' : null,
          hintText: 'Bitiş Tarihi Seçiniz',
          controller: viewModel.endDateController,
          suffixIcon: Icon(Icons.date_range, color: R.themeColor.primary),
          enabled: false,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('end_date'),
          errorLabel: viewModel.getErrorMsg('end_date'),
        ),
      );

  Widget _getFilterButton(BuildContext context, VmFragmentAccountBook viewModel) => Container(
        margin: viewModel.selectedSideBar == null ? const EdgeInsets.only(top: 20) : null,
        child: ButtonBasic(
          text: 'Filtrele',
          bgColor: R.themeColor.primaryLight,
          textColor: R.themeColor.primary,
          onPressed: () async {
            unawaited(viewModel.getData());
          },
        ),
      );

  Widget _getSelectedFilterButton(BuildContext context, VmFragmentAccountBook viewModel) => Container(
        margin: viewModel.selectedSideBar == null ? const EdgeInsets.only(top: 20) : null,
        child: ButtonBasic(
          text: 'Filtrele',
          bgColor: R.themeColor.primaryLight,
          textColor: R.themeColor.primary,
          onPressed: () async {
            unawaited(viewModel.getSelectedAccountBookDetail());
          },
        ),
      );

  Widget _getAddRegisterButton(BuildContext context, VmFragmentAccountBook viewModel) => Container(
        margin: viewModel.selectedSideBar == null ? const EdgeInsets.only(top: 20) : null,
        child: ButtonBasic(
          text: '+Kayıt Ekle',
          bgColor: R.themeColor.successLight,
          textColor: R.themeColor.success,
          onPressed: () async {
            unawaited(
              Provider.of<ServiceRoute>(context, listen: false).showBaseBottomSheet(
                context,
                isDismissible: false,
                BsAccountingReport(
                  type: AccountBookProcessType.create,
                  transactionType: viewModel.selectedAccountBookList?.first.accountTransactionCategoryId ?? -1,
                ),
              ),
            );
          },
        ),
      );

  Widget _getSideBarContainer(BuildContext context, VmFragmentAccountBook viewModel, List<ModelSideBar> sideBarModel, String header) => Container(
        decoration: BoxDecoration(
          color: R.themeColor.boxBg,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBasic(
              text: header,
              fontSize: 14,
              color: R.themeColor.secondaryHover,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            ...List.generate(
              sideBarModel.length,
              (index) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      viewModel.selectedSideBar = sideBarModel[index];
                      unawaited(viewModel.getSelectedAccountBookDetail());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextBasic(
                            text: sideBarModel[index].itemName ?? '',
                            fontSize: 14,
                            color: R.themeColor.secondaryHover,
                          ),
                        ),
                        Expanded(
                          child: TextBasic(
                            textAlign: TextAlign.end,
                            text: (sideBarModel[index].balance?.amount ?? 0).formatPrice(),
                            fontSize: 14,
                            color: (sideBarModel[index].balance?.amount ?? 0) < 0 ? R.themeColor.error : R.themeColor.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (index != sideBarModel.length - 1) Divider(color: R.themeColor.border) else const SizedBox(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _getDropdownWidget(BuildContext context, VmFragmentAccountBook viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: _getBankAccountSelection(context, viewModel),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: _getStartDatePicker(context, viewModel),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: _getEndDatePicker(context, viewModel),
          ),
          const SizedBox(width: 10),
          _getFilterButton(context, viewModel),
        ],
      );

  Widget _getSelectedDropDownWidget(BuildContext context, VmFragmentAccountBook viewModel) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.border),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBasic(text: viewModel.selectedSideBar?.groupName ?? '', fontSize: 14, color: R.themeColor.secondary, fontFamily: R.fonts.displayBold),
                const SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, size: 20, color: R.themeColor.primary),
                const SizedBox(width: 5),
                TextBasic(text: viewModel.selectedSideBar?.itemName ?? '', fontSize: 14, color: R.themeColor.primary, fontFamily: R.fonts.displayBold),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 2, child: _getStartDatePicker(context, viewModel)),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: _getEndDatePicker(context, viewModel)),
                const SizedBox(width: 10),
                _getSelectedFilterButton(context, viewModel),
                const SizedBox(width: 10),
                _getAddRegisterButton(context, viewModel),
              ],
            ),
          ],
        ),
      );

  WidgetCustomGraph _getChart(BuildContext context, VmFragmentAccountBook viewModel, ModelTurnoverData? model) {
    final labels = <String>[];
    final incomings = <ModelBalance>[];
    final expenseValues = <ModelBalance>[];
    final sellData = <ModelSalesData>[];
    final sellTitles = <String>[];

    sellTitles.add(model?.chart?.datasets!.first.name ?? '');
    model?.chart?.datasets!.first.values?.forEach((element) {
      incomings.add(ModelBalance(amount: element));
    });

    model?.chart?.labels?.forEach(labels.add);
    sellTitles.add(model?.chart?.datasets![1].name ?? '');
    model?.chart?.datasets![1].values?.forEach((element) {
      expenseValues.add(ModelBalance(amount: element));
    });
    if (labels.length == incomings.length && labels.length == expenseValues.length) {
      for (var i = 0; i < labels.length; i++) {
        sellData.add(ModelSalesData(labels[i], incomings[i], expenseValues[i]));
      }
    }

    return WidgetCustomGraph(
      data: sellData,
      xValueMapper: (data) => data.title!,
      yValueMapper: (data) => (data.incomeValue.amount ?? 0).toDouble(),
      seconYValueMapper: (data) => data.expenseValue.amount?.toDouble() ?? 0,
      buyLabelText: sellTitles.first,
      sellLabelText: sellTitles[1],
      header: '',
      firstBarColor: R.themeColor.success,
      secondBarColor: R.themeColor.error,
      borderColor: R.themeColor.border,
    );
  }

  WidgetCustomGraph _getSelectedCategoryChart(BuildContext context, VmFragmentAccountBook viewModel, ModelCategoryReport? model) {
    final labels = <String>[];
    final incomings = <ModelBalance>[];
    final expenseValues = <ModelBalance>[];
    final sellData = <ModelSalesData>[];
    final sellTitles = <String>[];

    sellTitles.add(model?.chart?.datasets!.first.name ?? '');
    model?.chart?.datasets!.first.values?.forEach((element) {
      incomings.add(ModelBalance(amount: element));
    });

    model?.chart?.labels?.forEach(labels.add);
    sellTitles.add(model?.chart?.datasets![1].name ?? '');
    model?.chart?.datasets![1].values?.forEach((element) {
      expenseValues.add(ModelBalance(amount: element));
    });
    if (labels.length == incomings.length && labels.length == expenseValues.length) {
      for (var i = 0; i < labels.length; i++) {
        sellData.add(ModelSalesData(labels[i], incomings[i], expenseValues[i]));
      }
    }

    return WidgetCustomGraph(
      data: sellData,
      xValueMapper: (data) => data.title!,
      yValueMapper: (data) => (data.incomeValue.amount ?? 0).toDouble(),
      seconYValueMapper: (data) => data.expenseValue.amount?.toDouble() ?? 0,
      buyLabelText: sellTitles.first,
      sellLabelText: sellTitles[1],
      header: '',
      firstBarColor: R.themeColor.success,
      secondBarColor: R.themeColor.error,
      borderColor: R.themeColor.border,
    );
  }

  Widget _getSelectedAccountBookWidget(BuildContext context, VmFragmentAccountBook viewModel) => ScrollWithNoGlowWidget(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: R.themeColor.primaryLight,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                border: Border.all(color: R.themeColor.border),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => {viewModel.sortAccountBookList(type: 'description', isDescending: viewModel.isAscending)},
                      child: Row(
                        children: [
                          TextBasic(text: 'Açıklama', color: R.themeColor.secondary, fontSize: 14),
                          Icon(CupertinoIcons.chevron_up_chevron_down, size: 14, color: R.themeColor.secondary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => viewModel.sortAccountBookList(type: 'date', isDescending: viewModel.isAscending),
                      child: Row(
                        children: [
                          TextBasic(text: 'Tarih & Saat', color: R.themeColor.secondary, fontSize: 14),
                          Icon(CupertinoIcons.chevron_up_chevron_down, size: 14, color: R.themeColor.secondary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => viewModel.sortAccountBookList(type: 'amount', isDescending: viewModel.isAscending),
                      child: Row(
                        children: [
                          TextBasic(text: 'Tutar', color: R.themeColor.secondary, fontSize: 14),
                          Icon(CupertinoIcons.chevron_up_chevron_down, size: 14, color: R.themeColor.secondary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => viewModel.sortAccountBookList(type: 'balance', isDescending: viewModel.isAscending),
                      child: Row(
                        children: [
                          TextBasic(text: 'Bakiye', color: R.themeColor.secondary, fontSize: 14),
                          Icon(CupertinoIcons.chevron_up_chevron_down, size: 14, color: R.themeColor.secondary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: viewModel.selectedAccountBookList?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final item = viewModel.selectedAccountBookList?[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (index == 0) const SizedBox(height: 15) else const SizedBox(height: 5),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: WidgetAccountBookDetail(data: item),
                    ),
                    Divider(color: R.themeColor.border),
                  ],
                );
              },
            ),
          ],
        ),
      );
}
