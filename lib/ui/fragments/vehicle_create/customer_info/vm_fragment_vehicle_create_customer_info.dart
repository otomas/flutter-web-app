import 'dart:async';

import '../../../../core/models/model_customer.dart';
import '../../../../core/models/request/model_request_vehicle.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmFragmentVehicleCreateCustomerInfo extends ViewModelBase {
  VmFragmentVehicleCreateCustomerInfo(this.serviceApi, this.params) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  final ModelRequestVehicleParams params;


  @override
  Future<void> init() async {}

  void onChangedSupplier(ModelCustomer? value, bool isAutoComplete) {
    params.supplier = value;
  }

  void onChangedSeller(ModelCustomer? value, bool isAutoComplete) {
    params.seller = value;
  }

  void onChangedBuyer(ModelCustomer? value, bool isAutoComplete) {
    params.buyer = value;
  }

  bool checkFields() {
    isDetectError = true;
    errorFields.clear();
    notifyListeners();

    var state = true;
    if (params.supplier == null && params.seller == null) {
      errorFields..addAll({'supplier_id': 'Tedarikçi veya Satıcı alanlarından en az biri zorunludur'})
      ..addAll({'seller_id': 'Tedarikçi veya Satıcı alanlarından en az biri zorunludur'});
      state = false;
    } else if ((params.buyer != null && (params.buyer?.id == params.supplier?.id || params.buyer?.id == params.seller?.id)) ||
        (params.supplier != null && (params.supplier?.id == params.buyer?.id || params.supplier?.id == params.seller?.id)) ||
        (params.seller != null && (params.seller?.id == params.buyer?.id || params.seller?.id == params.supplier?.id))) {
      errorFields
        ..addAll({'supplier_id': 'Alıcı, Satıcı ve Tedarikçi alanları aynı kişi olmamalıdır'})
        ..addAll({'seller_id': 'Alıcı, Satıcı ve Tedarikçi alanları aynı kişi olmamalıdır'})
        ..addAll({'buyer_id': 'Alıcı, Satıcı ve Tedarikçi alanları aynı kişi olmamalıdır'});
      state = false;
    } else {
      state = true;
    }
    if (!state) {
      errorObserver.message = 'Lütfen tüm alanları kontrol edin';
    }
    return state;
  }
}
