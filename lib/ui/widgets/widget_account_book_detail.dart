import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_date.dart';
import '../../core/extensions/extension_num.dart';
import '../../core/models/model_account_book_list.dart';
import '../../core/models/model_alert_dialog.dart';
import '../../core/models/model_sidebar.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_route.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import '../bs/bs_accounting_report.dart';
import 'widget_button.dart';
import 'widgets_text.dart';

class WidgetAccountBookDetail extends WidgetBase<VmWidgetAccountBookDetail> {
  const WidgetAccountBookDetail({required this.onDeleteSuccess, super.key, this.data, this.selectedSideBar});
  final ModelAccountBookList? data;
  final ModelSideBar? selectedSideBar;
  final Function(bool) onDeleteSuccess;

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetAccountBookDetail createViewModel(BuildContext context) => VmWidgetAccountBookDetail(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetAccountBookDetail viewModel) => getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetAccountBookDetail viewModel) => getBody(context, viewModel);

  Widget getBody(BuildContext context, VmWidgetAccountBookDetail viewModel) => Column(
        children: [
          GestureDetector(
            onTap: viewModel.setExpandState,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  viewModel.isExpanded ? CupertinoIcons.minus_circle : CupertinoIcons.plus_circle_fill,
                  color: !viewModel.isExpanded ? R.themeColor.primary : R.themeColor.secondary,
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: TextBasic(
                    text: '${data?.description?.category ?? ''}*${data?.description?.description ?? ''}',
                    fontSize: 14,
                    color: R.themeColor.secondary,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextBasic(
                    text: isWeb(context)
                        ? (data?.transactionDate ?? DateTime.now()).dayNameMonthNameAndHour()
                        : '${data?.transactionDate.dayMonthNameAndYear()}\n${data?.transactionDate.hourAndMinute()}',
                    fontSize: 14,
                    color: R.themeColor.secondary,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
                Expanded(
                  child: TextBasic(
                    text: data?.amount!.amount.formatPrice() ?? '',
                    fontSize: 14,
                    color: (data?.amount?.amount ?? -1) > 0 ? R.themeColor.success : R.themeColor.error,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
                Expanded(
                  child: TextBasic(
                    text: data?.balance?.amount.formatPrice() ?? '',
                    fontSize: 14,
                    color: (data?.balance?.amount ?? -1) > 0 ? R.themeColor.success : R.themeColor.error,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: !viewModel.isExpanded
                ? Container()
                : isWeb(context)
                    ? _getExpandedWidgetWeb(context, viewModel)
                    : _getExpandedWidgetWeb(context, viewModel),
          ),
        ],
      );

  Widget _getExpandedWidget(BuildContext context, VmWidgetAccountBookDetail viewModel) => _expandedContainer(context, viewModel);

  Widget _getExpandedWidgetWeb(BuildContext context, VmWidgetAccountBookDetail viewModel) => Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.border),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: _expandedContainer(context, viewModel),
      );

  Widget _expandedContainer(BuildContext context, VmWidgetAccountBookDetail viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextBasic(
                    text: 'İşlemi Yapan',
                    fontSize: 10,
                    color: R.themeColor.secondaryHover,
                  ),
                ),
                Expanded(
                  child: TextBasic(
                    text: data?.causer ?? '',
                    fontSize: 18,
                    color: data?.causer == 'Sistem' ? R.themeColor.warning : R.themeColor.infoHover,
                  ),
                ),
              ],
            ),
          ),
          if (data?.causer != 'Sistem')
            ButtonBasic(
              text: R.string.update,
              bgColor: R.themeColor.primaryLight,
              textColor: R.themeColor.primary,
              onPressed: () async {
                unawaited(
                  Provider.of<ServiceRoute>(context, listen: false).showBaseBottomSheet(
                    context,
                    isDismissible: false,
                    BsAccountingReport(
                      data: data,
                      selectedSideBar: selectedSideBar,
                      transactionType: data?.accountTransactionCategoryId ?? -1,
                      onUpdateSuccess: (var isSuccess) {
                        if (isSuccess) {
                          onDeleteSuccess(true);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          const SizedBox(width: 10),
          if (data?.causer != 'Sistem')
            ButtonBasic(
              text: R.string.delete,
              bgColor: R.themeColor.errorLight,
              textColor: R.themeColor.error,
              onPressed: () {
                viewModel.alertObserver.alert = ModelAlertDialog(
                  title: '',
                  dialogType: DialogTypes.confirmation,
                  description: 'Bu hesap hareketini silmek istediğinize emin misiniz?',
                  isDismissible: false,
                  onPressedButton: () {
                    unawaited(
                      viewModel
                          .deleteAccountBookDetail(
                        (data?.id ?? -1).toInt(),
                        selectedSideBar?.modelName ?? '',
                        (selectedSideBar?.modelId ?? -1).toInt(),
                      )
                          .then(
                        (value) {
                          if (value) {
                            onDeleteSuccess(true);
                            ModelAlertDialog(
                              title: '',
                              dialogType: DialogTypes.success,
                              description: 'Hesap hareketi başarıyla silindi.',
                              isDismissible: false,
                              onPressedButton: () {
                                Navigator.pop(context);
                              },
                            );
                          } else {
                            onDeleteSuccess(false);
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
        ],
      );
}

class VmWidgetAccountBookDetail extends ViewModelBase {
  VmWidgetAccountBookDetail(this.serviceApi) {
    unawaited(init());
  }

  bool isExpanded = false;

  final ServiceApi serviceApi;

  void setExpandState() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  @override
  Future<void> init() async {}

  Future<bool> deleteAccountBookDetail(int accountBookId, String accountModel, int accountId) async {
    setActivityState(ActivityState.isLoading);
    final response = await serviceApi.client.deleteAccountBookDetail(accountBookId, accountModel, accountId);
    setActivityState(ActivityState.isLoaded);
    return response.status;
  }
}
