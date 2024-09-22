import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/enums/enum_app.dart';
import '../../../../core/extensions/extension_balance.dart';
import '../../../../core/models/request/model_request_vehicle_info.dart';
import '../../../../core/models/response/model_response_vehicle_listing_info.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmFragmentVehicleDetailAdInfo extends ViewModelBase {
  VmFragmentVehicleDetailAdInfo(this.serviceApi, this.id) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  final int id;

  ModelVehicleListingInfoResponse? data;

  TextEditingController titleController = TextEditingController();
  TextEditingController foreignPriceController = TextEditingController();
  TextEditingController domesticPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Future<void> init() async {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getVehicleListingInfo(id).then(
      (response) {
        data = response.data;
        titleController.text = data?.vehicleListingInformation?.title ?? '';
        foreignPriceController = TextEditingController(text: data?.vehicleListingInformation?.priceForeign.formatPriceWithoutCurrency());
        domesticPriceController = TextEditingController(text: data?.vehicleListingInformation?.priceDomestic.formatPriceWithoutCurrency());
        descriptionController.text = data?.vehicleListingInformation?.description ?? '';
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  Future<bool> saveInfo() async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    final body = ModelRequestVehicleInfo(
      title: titleController.text,
      description: descriptionController.text,
      priceDomestic: int.tryParse(domesticPriceController.text.replaceAll('.', '')) ?? 0,
      priceForeign: int.tryParse(foreignPriceController.text.replaceAll('.', '')) ?? 0,
      priceDomesticCurrencyTypeId: 1,
      priceForeignCurrencyTypeId: 1,
    );
    await serviceApi.client.updateVehicleListingInformation(id, body).then(
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
