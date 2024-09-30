import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/enums/enum_app.dart';
import '../../../../core/extensions/extension_balance.dart';
import '../../../../core/models/model_vehicle_detail.dart';
import '../../../../core/models/response/model_response_vehicle_status.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmVehicleDoping extends ViewModelBase {
  VmVehicleDoping(this.serviceApi, this.vehicleId, this.branchId) {
    unawaited(init());
  }

  final ServiceApi serviceApi;
  final int vehicleId;
  final int? branchId;

  final TextEditingController buyingPriceController = TextEditingController();
  final TextEditingController domesticPriceController = TextEditingController();
  final TextEditingController foreignPriceController = TextEditingController();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  ModelVehicleDetail? data;
  ModelVehicleStatus? vehicleStatus;

  ValueNotifier<bool> isPublishPriceDomestic = ValueNotifier<bool>(false);
  ValueNotifier<bool> isPublishPriceForeign = ValueNotifier<bool>(false);

  @override
  Future<void> init() async {
    setActivityState(ActivityState.isLoading);
    await getData();
    setActivityState(ActivityState.isLoaded);
  }

  void setIsPublishPriceDomestic(bool? value) {
    isPublishPriceDomestic.value = !(vehicleStatus?.isPublishPriceDomestic ?? false);
  }

  void setIsPublishPriceForeign(bool? value) {
    isPublishPriceForeign.value = !(vehicleStatus?.isPublishPriceForeign ?? false);
  }

  Future<void> getData() async {
    await serviceApi.client.getVehicleDetail(vehicleId).then(
      (response) {
        data = response.data;
        buyingPriceController.text = data?.price.formatPriceWithoutCurrency() ?? '';
        titleController.text = data?.vehicleListingInformation?.title ?? '';
        descriptionController.text = data?.vehicleListingInformation?.description ?? '';
      },
      onError: (error) {
        handleApiError(error);
      },
    );
  }

  Future<void> getVehicleStatus() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getVehicleStatus(vehicleId).then(
      (response) {
        vehicleStatus = response.data;
        isPublishPriceDomestic.value = vehicleStatus?.isPublishPriceDomestic ?? false;
        isPublishPriceForeign.value = vehicleStatus?.isPublishPriceForeign ?? false;

        domesticPriceController.text = vehicleStatus?.priceDomestic.formatPriceWithoutCurrency() ?? '';
        foreignPriceController.text = vehicleStatus?.priceForeign.formatPriceWithoutCurrency() ?? '';
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }
}
