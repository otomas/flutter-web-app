// ignore_for_file: avoid_catches_without_on_clauses, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_balance.dart';
import '../../core/extensions/extension_date.dart';
import '../../core/models/model_account_book_list.dart';
import '../../core/models/model_dropdown.dart';
import '../../core/models/model_sidebar.dart';
import '../../core/models/request/model_request_add_accounting_book.dart';
import '../../core/models/response/model_transaction_categories.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/utils/alert_utils.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import '../widgets/widget_button.dart';
import '../widgets/widget_checkbox.dart';
import '../widgets/widget_dropdown.dart';
import '../widgets/widget_textfield.dart';
import '../widgets/widgets_text.dart';

class BsAccountingReport extends StatefulWidget {
  const BsAccountingReport({
    required this.type,
    required this.transactionType,
    this.data,
    super.key,
  });
  final AccountBookProcessType type;
  final num transactionType;
  final ModelAccountBookList? data;

  @override
  State<BsAccountingReport> createState() => _BsAccountingReportState();
}

class _BsAccountingReportState extends WidgetBaseStatefull<BsAccountingReport, VmBsAccountingReport> {
  @override
  VmBsAccountingReport createViewModel(BuildContext context) => VmBsAccountingReport(apiService(context),widget.type,widget.data);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsAccountingReport viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsAccountingReport viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsAccountingReport viewModel) => Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBasic(
              text: 'Kayıt Ekle',
              color: R.themeColor.secondary,
              fontFamily: R.fonts.displayBold,
              fontSize: 20,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                CheckboxBasic(
                  key: UniqueKey(),
                  item: viewModel.radioButtonList[0],
                  value: viewModel.selectedType == viewModel.radioButtonList[0],
                  onChanged: (v) => viewModel.setSelectedType(viewModel.radioButtonList[0]),
                  isRadioButton: true,
                  isInnerScroll: true,
                ),
                const SizedBox(width: 10),
                CheckboxBasic(
                  key: UniqueKey(),
                  item: viewModel.radioButtonList[1],
                  value: viewModel.selectedType == viewModel.radioButtonList[1],
                  onChanged: (v) => viewModel.setSelectedType(viewModel.radioButtonList[1]),
                  isRadioButton: true,
                  isInnerScroll: true,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: DropdownBasic(
                    key: UniqueKey(),
                    selectedItem: viewModel.selectedTransactionType,
                    // ignore: discarded_futures
                    items: viewModel.transactionCategories,
                    onChanged: viewModel.setSelectedTransactionType,
                    title: 'Kategori Seçimi',
                    hasError: viewModel.isDetectError && viewModel.selectedTransactionType == null,
                    errorLabel: R.string.pleaseSelect,
                    hint: 'Seçiniz',
                    isRequired: true,
                  ),
                ),
                if (widget.type == AccountBookProcessType.create) const SizedBox(width: 15),
                if (widget.type == AccountBookProcessType.create)
                  Expanded(
                    child: DropdownBasic(
                      key: UniqueKey(),
                      title: R.string.accountSelection,
                      hint: 'Seçiniz',
                      // ignore: discarded_futures
                      items: viewModel.sideBarListData,
                      selectedItem: viewModel.selectedBankAccount,
                      hasError: viewModel.detectFieldError && viewModel.selectedBankAccount == null,
                      errorLabel: R.string.pleaseSelect,
                      onChanged: viewModel.setSelectedBankAccount,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFieldBasic(
                    controller: viewModel.descriptionController,
                    title: 'Açıklama Seçimi',
                    hintText: 'Açıklama Giriniz',
                    hasError: viewModel.isDetectError,
                    errorLabel: R.string.pleaseSelect,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextFieldBasic(
                    controller: viewModel.priceController,
                    title: 'Tutar Giriniz',
                    hintText: 'Seçiniz',
                    textColor: R.themeColor.error,
                    hasError: viewModel.isDetectError,
                    errorLabel: R.string.pleaseFill,
                    keyboardType: TextInputType.number,
                    isRequired: true,
                  ),
                ),
              ],
            ),
            Container(height: 20),
            Row(
              children: [
                Expanded(
                  child: _getStartDatePicker(context, viewModel),
                ),
                Expanded(
                  child: _getEndDatePicker(context, viewModel),
                ),
              ],
            ),
            Container(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(child: TextBasic(text: '')),
                ButtonBasic(
                  bgColor: R.color.white,
                  textColor: R.themeColor.secondary,
                  text: 'Vazgeç',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 20),
                ButtonBasic(
                  bgColor: widget.type == AccountBookProcessType.create ? R.themeColor.successLight : R.themeColor.primaryLight,
                  textColor: widget.type == AccountBookProcessType.create ? R.themeColor.success : R.themeColor.primary,
                  text: widget.type == AccountBookProcessType.create ? 'Kaydet' : 'Güncelle',
                  onPressed: () async {
                    if (await viewModel.addAccountingBook(widget.transactionType)) {
                      unawaited(viewModel.getSideBarData());
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      );

  Widget _getStartDatePicker(BuildContext context, VmBsAccountingReport viewModel) => GestureDetector(
        onTap: () async {
          await showCustomDatePicker(
            context,
            initial: viewModel.date,
            min: DateTime.now().add(const Duration(days: 365 * -10)),
            max: DateTime.now(),
            onConfirm: (date, _) {
              setState(() {
                viewModel.date = date;
                viewModel.dateController.text = date.dayMonthNameAndYear();
              });
            },
          );
        },
        child: TextFieldBasic(
          title: 'Başlangıç Tarihi',
          hintText: 'Başlangıç Tarihi Seçiniz',
          controller: viewModel.dateController,
          suffixIcon: Icon(Icons.date_range, color: R.themeColor.primary),
          enabled: false,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('start_date'),
          errorLabel: viewModel.getErrorMsg('start_date'),
        ),
      );

  Widget _getEndDatePicker(BuildContext context, VmBsAccountingReport viewModel) => GestureDetector(
        onTap: () async {
          await showCustomTimePicker(
            context,
            initial: viewModel.hour,
            min: DateTime.now().add(const Duration(days: 365 * -10)),
            max: DateTime.now(),
            onConfirm: (date, _) {
              setState(() {
                viewModel.hour = date;
                viewModel.hourController.text = date.hourAndMinute();
              });
            },
          );
        },
        child: TextFieldBasic(
          title: 'Saat',
          hintText: 'Saat Seçiniz',
          controller: viewModel.hourController,
          suffixIcon: Icon(Icons.date_range, color: R.themeColor.primary),
          enabled: false,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('hour'),
          errorLabel: viewModel.getErrorMsg('hour'),
        ),
      );
}

class VmBsAccountingReport extends ViewModelBase {
  VmBsAccountingReport(this.serviceApi,this.type,this.data) {
    unawaited(init());
  }

  final ServiceApi serviceApi;
  final AccountBookProcessType type;
  final ModelAccountBookList? data;

  bool detectFieldError = false;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  var radioButtonList = [
    const ModelDropdown(id: 0, title: 'Gelir'),
    const ModelDropdown(id: 1, title: 'Gider'),
  ];

  DateTime? date;
  DateTime? hour;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();

  List<ModelTransactionCategories> transactionCategories = [];
  ModelTransactionCategories? selectedTransactionType;

  Map<String, List<ModelSideBar>> sideBarList = {};
  List<ModelSideBar>? sideBarListData;
  ModelSideBar? selectedBankAccount;

  ModelDropdown? selectedType;

  @override
  Future<void> init() async {
    selectedType = radioButtonList.first;
    unawaited(getTransactionCategories());
    if(data == null) {
      unawaited(getSideBarData());
    }else{
      selectedBankAccount = ModelSideBar(
        modelId: data?.accountTransactionCategoryId ?? -1,
        modelName: data?.transactionType ?? '',
      );
      descriptionController.text = data?.description?.description ?? '';
      priceController.text = data?.amount.formatPrice() ?? '';
      date = data?.transactionDate;
      hour = data?.transactionDate;
      dateController.text = data?.transactionDate.dayMonthNameAndYear() ?? '';
      hourController.text = data?.transactionDate.hourAndMinute() ?? '';
    }
  }

  Future<bool> addAccountingBook(
    num transactionType,
  ) async {
    final model = ModelRequestAddAccountingBook(
      selectedBankAccount?.modelName ?? '',
      selectedBankAccount?.modelId ?? -1,
      transactionType,
      '${DateTime.now().yearMonthDay()} ${DateTime.now().hourAndMinute()}',
      'credit',
      selectedBankAccount?.modelName ?? '',
      selectedBankAccount?.modelId ?? -1,
      priceController.text.isEmpty ? 0 : num.parse(priceController.text),
      100,
      descriptionController.text,
    );
    return _addAccountingBookData(model);
  }

  Future<bool> _addAccountingBookData(ModelRequestAddAccountingBook model) async {
    setActivityState(ActivityState.isLoading);
    try {
      final response = await serviceApi.client.addAccountingBookData(model);
      return response.status;
    } catch (_err) {
      await handleApiError(_err);
    }
    setActivityState(ActivityState.isLoaded);
    return false;
  }

  Future<void> getTransactionCategories() async {
    setActivityState(ActivityState.isLoading);
    try {
      final response = await serviceApi.client.getTransactionCategories();
      if (response.data != null) {
        transactionCategories = response.data ?? [];
      }
    } catch (e) {
      await handleApiError(e);
    }
    setActivityState(ActivityState.isLoaded);
  }

  Future<void> getSideBarData() async {
    setActivityState(ActivityState.isLoading);
    try {
      final response = await serviceApi.client.getSidebar();
      if (response.data != null) {
        final temp = response.data!;
        sideBarList = groupByGroupName(temp);
        sideBarListData = distincSideBarList();
      }
    } catch (_err) {
      await handleApiError(_err);
    }
    setActivityState(ActivityState.isLoaded);
  }

  Map<String, List<ModelSideBar>> groupByGroupName(List<ModelSideBar> list) => list.fold<Map<String, List<ModelSideBar>>>(
        {},
        (map, item) {
          final groupName = item.groupName ?? '';
          if (!map.containsKey(groupName)) {
            map[groupName] = [];
          }
          map[groupName]?.add(item);
          return map;
        },
      );

  List<ModelSideBar> distincSideBarList() {
    final list = <ModelSideBar>[];
    sideBarList.forEach((key, value) {
      for (final item in value) {
        final exists = list.any((element) => element.dropdownTitle == item.dropdownTitle);
        if (!exists) {
          list.add(item);
        }
      }
    });
    return list;
  }

  void setSelectedType(ModelDropdown item) {
    selectedType = item;
    notifyListeners();
  }

  void setSelectedTransactionType(ModelTransactionCategories? item, bool isAutoComplete) {
    selectedTransactionType = item;
  }

  void setSelectedBankAccount(ModelSideBar? model, bool isAutoComplete) {
    if (selectedBankAccount == model) {
      return;
    }
    selectedBankAccount = model;
  }
}
