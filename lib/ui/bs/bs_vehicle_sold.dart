import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/enums/enum_api.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_balance.dart';
import '../../core/extensions/extension_date.dart';
import '../../core/models/model_balance.dart';
import '../../core/models/model_customer.dart';
import '../../core/models/model_payment_type.dart';
import '../../core/models/model_value.dart';
import '../../core/models/request/model_request_payment_type.dart';
import '../../core/models/request/model_request_vehicle_sold.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_firebase.dart';
import '../../core/utils/formatters.dart';
import '../../ui/base/base_view.dart';
import '../../ui/base/base_view_model.dart';
import '../widgets/widget_button.dart';
import '../widgets/widget_dropdown.dart';
import '../widgets/widget_payment_card.dart';
import '../widgets/widget_scroll.dart';
import '../widgets/widget_textfield.dart';
import '../widgets/widgets_text.dart';
import 'bs_dropdown.dart';

class BsVehicleSold extends StatefulWidget {
  const BsVehicleSold({
    required this.vehicleId,
    required this.onSuccess,
    this.sellingPrice,
    super.key,
  });

  final int vehicleId;
  final ModelBalance? sellingPrice;
  final Function() onSuccess;

  @override
  State<BsVehicleSold> createState() => _BsVehicleSoldState();
}

class _BsVehicleSoldState extends WidgetBaseStatefull<BsVehicleSold, VmBsVehicleSold> {
  @override
  VmBsVehicleSold createViewModel(BuildContext context) => VmBsVehicleSold(apiService(context), firebaseService(context), widget.vehicleId, widget.sellingPrice);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsVehicleSold viewModel) => buildWidget(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsVehicleSold viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsVehicleSold viewModel) => Column(
        children: [
          Expanded(
            child: ScrollWithNoGlowWidget(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextBasic(
                      text: 'Aracımı Sattım',
                      color: R.themeColor.secondary,
                      fontFamily: R.fonts.displayBold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownBasic(
                      title: 'Aracı Alan Kişi',
                      onChanged: viewModel.setSelectedBuyer,
                      // ignore: discarded_futures
                      callback: () => apiService(context).client.getCustomers(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now().add(const Duration(days: -365 * 10)),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          viewModel.setSelectedSellingDate(date);
                        }
                      },
                      child: TextFieldBasic(
                        enabled: false,
                        title: 'Aracın Satış Tarihi',
                        suffixIcon: Icon(Icons.date_range, color: R.themeColor.primary),
                        textColor: R.themeColor.secondaryHover,
                        fontFamily: R.fonts.displayMedium,
                        controller: TextEditingController(text: viewModel.sellingDate.dayMonthNameAndYear()),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFieldBasic(
                      enabled: false,
                      title: 'Listedeki Satış Fiyatı',
                      suffixIcon: TextBasic(text: '₺', color: R.themeColor.smokeDark),
                      textColor: R.color.candy,
                      controller: TextEditingController(text: widget.sellingPrice.formatPrice()),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFieldBasic(
                      title: 'Mutabık Olunan Satış Fiyatı',
                      textColor: R.color.candy,
                      controller: viewModel.agreedSellingPriceController,
                      keyboardType: TextInputType.number,
                      suffixIcon: TextBasic(text: '₺', color: R.themeColor.smokeDark),
                      inputFormatters: [DecimalFormatter()],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _getPaymentTypes(context, viewModel),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ButtonBasic(
                    onPressed: () => Navigator.pop(context),
                    text: 'Vazgeç',
                    textColor: R.themeColor.secondaryHover,
                    bgColor: R.color.transparent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ButtonBasic(
                    onPressed: () async {
                      final v = await viewModel.soldVehicle();
                      if (v && context.mounted) {
                        Navigator.pop(context);
                        widget.onSuccess();
                      }
                    },
                    text: 'Hayırlı Olsun',
                    textColor: R.color.brown,
                    bgColor: R.themeColor.highlighted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      );

  Widget _getPaymentTypes(BuildContext context, VmBsVehicleSold viewModel) => Container(
        width: size(context).width,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextBasic(
                    text: 'Satış için ödeme yöntemi ekleyiniz',
                    color: R.themeColor.primary,
                    fontFamily: R.fonts.displayMedium,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    unawaited(
                      router(context).showBaseBottomSheet(
                        context,
                        BottomSheetDropdown(
                          list: viewModel.paymentTypes,
                          onChanged: viewModel.addPaymentType,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: R.themeColor.primary,
                    ),
                    child: Icon(Icons.add, color: R.color.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...List.generate(
              viewModel.selectedPaymentTypes.length,
              (index) {
                final item = viewModel.selectedPaymentTypes[index];
                return WidgetPaymentCard(
                  selectedPaymentType: item,
                  onChangedPaymentType: (v, _) => viewModel.setSelectedPaymentType(index, v),
                  onChangedAccountType: (v, _) => viewModel.setSelectedAccountType(index, v),
                  onPressedRemove: () => viewModel.removeSelectedPaymentType(index),
                  paymentTypes: viewModel.paymentTypes,
                );
              },
            ),
          ],
        ),
      );
}

class VmBsVehicleSold extends ViewModelBase {
  VmBsVehicleSold(this.serviceApi, this.serviceFirebase, this.vehicleId, this.sellingPrice) {
    init();
  }

  final ServiceApi serviceApi;
  final ServiceFirebase serviceFirebase;
  final int vehicleId;

  ModelCustomer? buyer;
  DateTime sellingDate = DateTime.now();
  ModelBalance? sellingPrice;
  TextEditingController agreedSellingPriceController = TextEditingController();

  List<ModelPaymentType> paymentTypes = [];
  List<ModelPaymentType> selectedPaymentTypes = [];

  @override
  void init() {
    unawaited(getPaymentTypes());
  }

  Future<void> getPaymentTypes() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getPaymentTypes().then(
      (response) {
        paymentTypes = response.data ?? [];
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  void addPaymentType(ModelPaymentType item) {
    selectedPaymentTypes.add(ModelPaymentType.copyWith(item));
    notifyListeners();
  }

  void setSelectedPaymentType(int index, ModelPaymentType? type) {
    if (type != null) {
      return;
    }
    selectedPaymentTypes[index] = type!;
    notifyListeners();
  }

  void setSelectedAccountType(int index, ModelValue? account) {
    selectedPaymentTypes[index].selectedItem = account;
    notifyListeners();
  }

  void removeSelectedPaymentType(int index) {
    selectedPaymentTypes.removeAt(index);
    notifyListeners();
  }

  void setSelectedBuyer(ModelCustomer? customer, bool isAutComplete) {
    buyer = customer;
  }

  void setSelectedSellingDate(DateTime date) {
    sellingDate = date;
    notifyListeners();
  }

  Future<bool> soldVehicle() async {
    if (buyer == null) {
      errorObserver.message = 'Aracı Alan Kişi alanı boş bırakılamaz';
      return false;
    }
    if (agreedSellingPriceController.text.isEmpty) {
      errorObserver.message = 'Mutabık Olunan Satış Fiyatı boş bırakılamaz';
      return false;
    }
    if (double.tryParse(agreedSellingPriceController.text.replaceAll('.', '')) == null) {
      errorObserver.message = 'Mutabık Olunan Satış Fiyatı alanını sadece fiyat bilgisi olarak girin';
      return false;
    }
    if (selectedPaymentTypes.isEmpty) {
      errorObserver.message = 'Lütfen ödeme yöntemi ekleyin';
      return false;
    }
    final index = selectedPaymentTypes.indexWhere((element) => double.tryParse(element.amountController!.text.replaceAll('.', '')) == null);
    if (index != -1) {
      errorObserver.message = 'Lütfen ödeme yöntemine girdiğiniz tutarları kontrol edin';
      return false;
    }
    var totalAmount = 0;
    for (final element in paymentTypes) {
      totalAmount += (double.tryParse((element.amountController?.text ?? '').replaceAll('.', '')) ?? 0).toInt();
    }
    if (agreedSellingPriceController.text.isNotEmpty && totalAmount != (double.tryParse(agreedSellingPriceController.text) ?? 0).toInt()) {
      errorFields.addAll({'payments': 'Aracın alış fiyatı ile girilen tutarlar uyuşmamaktadır'});
    }

    // ignore: no_leading_underscores_for_local_identifiers
    final _paymentTypes = <ModelRequestPaymentType>[];
    for (final element in selectedPaymentTypes) {
      _paymentTypes.add(
        ModelRequestPaymentType(
          paymentTypeId: element.id,
          amount: int.tryParse(element.amountController!.text.replaceAll('.', '')) ?? 0,
          bankAccountId: element.id == PaymentType.bankTransfer.id ? element.selectedItem!.id : null,
          branchPosDeviceId: element.id == PaymentType.creditCard.id ? element.selectedItem!.id : null,
        ),
      );
    }

    var state = false;
    setActivityState(ActivityState.isLoading);
    final body = ModelRequestVehicleSold(
      buyerId: buyer!.id,
      salesAt: sellingDate,
      payments: _paymentTypes,
      agreedSellingPrice: int.tryParse(agreedSellingPriceController.text.replaceAll('.', '')) ?? 0,
    );
    await serviceApi.client.soldVehicle(vehicleId, body).then(
      (response) {
        state = true;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
    return state;
  }
}
