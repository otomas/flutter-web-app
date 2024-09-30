import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/enums/enum_app.dart';
import '../../../../core/models/model_payment_type.dart';
import '../../../../core/models/model_value.dart';
import '../../../../core/models/request/model_request_vehicle.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmFragmentVehicleCreatePrices extends ViewModelBase {
  VmFragmentVehicleCreatePrices(this.serviceApi, this.params) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  final ModelRequestVehicleParams params;

  List<ModelPaymentType> paymentTypes = [];

  ValueNotifier<double> remainingBalance = ValueNotifier<double>(0);

  @override
  Future<void> init() async {
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

  bool checkFields() {
    isDetectError = true;
    errorFields.clear();
    notifyListeners();

    var totalAmount = 0;
    for (final element in params.paymentTypes) {
      totalAmount += (double.tryParse(element.amountController!.text.replaceAll('.', '')) ?? 0).toInt();
    }
    if (params.buyingPriceController.text.isNotEmpty && totalAmount != (double.tryParse(params.buyingPriceController.text.replaceAll('.', '')) ?? 0).toInt()) {
      errorFields.addAll({'payments': 'Aracın alış fiyatı ile girilen tutarlar uyuşmamaktadır'});
    }
    if (errorFields.isEmpty) {
      return true;
    } else {
      errorObserver.message = 'Lütfen tüm alanları kontrol edin';
      return false;
    }
  }

  void addPaymentType(ModelPaymentType item) {
    params.paymentTypes.add(ModelPaymentType.copyWith(item));
    params.paymentTypes.last.amountController?.addListener(priceListener);
    notifyListeners();
  }

  void setSelectedPaymentType(int index, ModelPaymentType? type) {
    if (type != null) {
      params.paymentTypes[index] = type;
      notifyListeners();
    }
  }

  void setSelectedAccountType(int index, ModelValue? account) {
    params.paymentTypes[index].selectedItem = account;
    notifyListeners();
  }

  void removeSelectedPaymentType(int index) {
    params.paymentTypes[index].amountController?.removeListener(priceListener);
    params.paymentTypes.removeAt(index);
    notifyListeners();
  }

  void priceListener() {
    var price = 0.0;
    for (final element in params.paymentTypes) {
      price += double.tryParse(element.amountController?.text.replaceAll('.', '') ?? '0') ?? 0;
    }
    final buyingPrice = int.tryParse(params.buyingPriceController.text.replaceAll('.', '')) ?? 0;
    remainingBalance.value = buyingPrice - price;
  }
}
