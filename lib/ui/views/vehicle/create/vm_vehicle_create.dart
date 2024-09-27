import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/enum_api.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/extensions/extension_balance.dart';
import '../../../../core/extensions/extension_num.dart';
import '../../../../core/models/model_alert_dialog.dart';
import '../../../../core/models/model_customer.dart';
import '../../../../core/models/model_dropdown.dart';
import '../../../../core/models/model_payment_type.dart';
import '../../../../core/models/model_router_destinition.dart';
import '../../../../core/models/model_value.dart';
import '../../../../core/models/model_vehicle_body_type.dart';
import '../../../../core/models/model_vehicle_brands.dart';
import '../../../../core/models/model_vehicle_fuel_type.dart';
import '../../../../core/models/model_vehicle_model.dart';
import '../../../../core/models/model_vehicle_series.dart';
import '../../../../core/models/model_vehicle_traction_type.dart';
import '../../../../core/models/model_vehicle_transmission_type.dart';
import '../../../../core/models/model_vehicle_type.dart';
import '../../../../core/models/model_vehicle_version.dart';
import '../../../../core/models/request/model_request_vehicle.dart';
import '../../../../core/models/response/model_response_vehicle_color_flaw_groups.dart';
import '../../../../core/models/response/model_response_vehicle_report_checklist.dart';
import '../../../../core/models/response_data.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/services/router/router.gr.dart';
import '../../../../core/services/service_api.dart';
import '../../../../core/services/service_route.dart';
import '../../../../core/utils/general_data.dart';
import '../../../base/base_view_model.dart';

class VmVehicleCreate extends ViewModelBase {
  VmVehicleCreate(this.serviceApi, this.serviceRoute, this.vehicleId, this.branchId) {
    unawaited(init());
  }

  final ServiceApi serviceApi;
  final ServiceRoute serviceRoute;

  final int? vehicleId;
  final int? branchId;

  final List<RouteDestination> fragments = [];

  late TabsRouter tabsRouter;
  void setTabsRouter(TabsRouter r) => tabsRouter = r;

  late ModelRequestVehicleParams vehicleParams;

  List<String> customerInfoErrorFields = [
    'supplier_id',
    'seller_id',
    'buyer_id',
  ];

  List<String> vehicleInfoErrorFields = [
    'vehicle_type',
    'brand',
    'series',
    'vehicle_model_id',
    'vehicle_version_id',
    'model_year',
    'vehicle_fuel_type_id',
    'vehicle_body_type_id',
    'vehicle_transmission_type_id',
    'vehicle_traction_type_id',
    'chassis_number',
    'engine_power',
    'kilometer',
    'plate_number',
    'color',
  ];

  List<String> priceInfoErrorFields = [
    'payments',
  ];

  @override
  Future<void> init() async {
    vehicleParams = ModelRequestVehicleParams(this, GeneralData.getInstance().getTokenData()?.autoGalleryBranchId ?? 0);
    if (vehicleId != null) {
      await getVehicleDetail();
    }
    fragments
      ..add(
        RouteDestination(
          iconSvgPath: R.drawable.svg.iconCars,
          label: 'Alıcı Satıcı ve\nTedariskçi Bilgileri',
          route: FragmentVehicleCreateCustomerInfo(
            params: vehicleParams,
            onPressedNextButton: prepareVehicleParams,
            onPressedPreviousButton: onPressedPrevious,
          ),
        ),
      )
      ..add(
        RouteDestination(
          iconSvgPath: R.drawable.svg.iconCars,
          label: 'Araç Özellikleri,\nSigorta Muayene',
          route: FragmentVehicleCreateInfo(
            params: vehicleParams,
            onPressedNextButton: prepareVehicleParams,
            onPressedPreviousButton: onPressedPrevious,
          ),
        ),
      )
      ..add(
        RouteDestination(
          route: FragmentVehicleCreateExpertise(
            params: vehicleParams,
            onPressedNextButton: prepareVehicleParams,
            onPressedPreviousButton: onPressedPrevious,
          ),
          iconSvgPath: R.drawable.svg.iconCars,
          label: 'Araç Ekspertiz\nBilgileri',
        ),
      )
      ..add(
        RouteDestination(
          route: FragmentVehicleCreatePrices(
            params: vehicleParams,
            onPressedNextButton: prepareVehicleParams,
            onPressedPreviousButton: onPressedPrevious,
          ),
          iconSvgPath: R.drawable.svg.iconCars,
          label: 'Araç Fiyat\nBilgileri',
        ),
      );
  }

  void prepareVehicleParams(ModelRequestVehicleParams newParams) {
    vehicleParams = newParams;
    nextPage();
  }

  void nextPage() {
    if (tabsRouter.activeIndex == fragments.length - 1) {
      unawaited(createVehicle());
      return;
    } else {
      tabsRouter.setActiveIndex(tabsRouter.activeIndex + 1);
    }
  }

  Future<void> getVehicleDetail() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getVehicleDetail(vehicleId!).then(
      (response) {
        if (response.data != null) {
          final colorFlawGroups = <ModelVehicleColorFlawGroup>[];
          final expertiseItems = <ModelVehicleReportChecklist, ModelVehicleColorFlawGroup>{};
          response.data?.colorFlaws?.forEach(
            (element) {
              expertiseItems.addAll({element.colorReportChecklist: element.colorFlawGroup});
              if (!colorFlawGroups.any((e) => e.id == element.colorFlawGroup.id)) {
                colorFlawGroups.add(element.colorFlawGroup);
              }
            },
          );
          vehicleParams
            ..supplier = response.data?.supplier == null ? null : ModelCustomer(id: response.data?.supplier?.id ?? 0)
            ..seller = response.data?.seller == null ? null : ModelCustomer(id: response.data?.seller?.id ?? 0)
            ..buyer = response.data?.buyer == null ? null : ModelCustomer(id: response.data?.buyer?.id ?? 0)
            ..vehicleType = response.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleType == null ? null : ModelVehicleType(id: response.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleType?.id ?? 0)
            ..brand = response.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand == null ? null : ModelVehicleBrand(id: response.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.id ?? 0)
            ..series = response.data?.vehicleVersion?.vehicleModel?.vehicleSeries == null ? null : ModelVehicleSeries(id: response.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.id ?? 0)
            ..model = response.data?.vehicleVersion?.vehicleModel == null ? null : ModelVehicleModel(id: response.data?.vehicleVersion?.vehicleModel?.id ?? 0)
            ..version = response.data?.vehicleVersion == null ? null : ModelVehicleVersion(id: response.data?.vehicleVersion?.id ?? 0)
            ..bodyType = response.data?.vehicleBodyType == null ? null : ModelVehicleBodyType(id: response.data?.vehicleBodyType?.id ?? 0)
            ..transmissionType = response.data?.vehicleTransmissionType == null ? null : ModelVehicleTransmissionType(id: response.data?.vehicleTransmissionType?.id ?? 0)
            ..tractionType = response.data?.vehicleTractionType == null ? null : ModelVehicleTractionType(id: response.data?.vehicleTractionType?.id ?? 0)
            ..fuelType = response.data?.vehicleFuelType == null ? null : ModelVehicleFuelType(id: response.data?.vehicleFuelType?.id ?? 0)
            ..kilometerController = TextEditingController(text: response.data?.kilometer.formatPrice())
            ..enginePowerController = TextEditingController(text: response.data?.enginePower.formatPrice())
            ..engineCapacity = TextEditingController(text: response.data?.engineCapacity.formatPrice())
            ..year = response.data?.modelYear == null ? null : ModelDropdown(id: response.data?.modelYear ?? 0, title: '-')
            ..plateNumberController = TextEditingController(text: response.data?.plateNumber)
            ..chassisNumberController = TextEditingController(text: response.data?.chassisNumber)
            ..insuranceStartDate = response.data?.insuranceStartDate
            ..insuranceEndDate = response.data?.insuranceEndDate
            ..inspectionStartDate = response.data?.inspectionStartDate
            ..inspectionEndDate = response.data?.inspectionEndDate
            ..selectedExpertiseItems = expertiseItems
            ..buyingDate = response.data?.purchasedAt
            ..buyingPriceController = TextEditingController(text: response.data?.price.formatPriceWithoutCurrency())
            ..sellingPriceController = TextEditingController(text: response.data?.agreedSellingPrice.formatPriceWithoutCurrency());

          for (var i = 0; i < (response.data!.purchasePayments ?? []).length; i++) {
            final item = response.data!.purchasePayments![i];
            vehicleParams.paymentTypes.add(
              ModelPaymentType(
                id: item.paymentTypeId.id,
                name: item.paymentType,
                selectedItem: ModelValue(id: item.paymentLocationId, name: item.paymentLocation),
                amountController: TextEditingController(text: item.amount!.amount.formatPrice()),
                items: item.paymentTypeId == PaymentType.cash ? null : [ModelValue(id: item.paymentLocationId, name: item.paymentLocation)],
              ),
            );
          }
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  Future<void> createVehicle() async {
    if (vehicleId != null) {
      unawaited(updateVehicle());
      return;
    }
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.createVehicle(vehicleParams.vehicleRequestModel).then(
      (response) {
        if (response.data?.id != null) {
          alertObserver.alert = ModelAlertDialog(
            dialogType: DialogTypes.success,
            title: 'Aracınız oluşturuldu',
            description: 'Aracınız başarıyla oluşturuldu.',
            isDismissible: false,
            onPressedButton: () {
              serviceRoute.startNewView(route: RouteVehicleDetail(vehicleId: response.data!.id), isReplace: true, clearStack: true);
            },
          );
        } else {
          serviceRoute.onBackPressed();
        }
      },
      onError: (error) {
        handleApiError(error);
        if (error is DioException) {
          handleCustomApiError(error);
        }
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  Future<void> updateVehicle() async {
    if (vehicleId == null) {
      return;
    }
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.updateVehicle(vehicleId!, vehicleParams.vehicleRequestModel).then(
      (response) {
        serviceRoute.startNewView(route: RouteVehicleDetail(vehicleId: response.data?.id ?? vehicleId!), isReplace: true);
      },
      onError: (error) {
        handleApiError(error);
        if (error is DioException) {
          handleCustomApiError(error);
        }
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  void onPressedPrevious() {
    if (tabsRouter.activeIndex == 0) {
      unawaited(serviceRoute.startNewView(route: RouteHome(), clearStack: true, isReplace: true));
      return;
    } else {
      tabsRouter.setActiveIndex(tabsRouter.activeIndex - 1);
    }
  }

  void handleCustomApiError(DioException error) {
    final res = JsonMapper.deserialize<ResponseData>(error.response?.data);
    if (res?.error?.fields?.keys.firstWhereOrNull((e) => customerInfoErrorFields.contains(e)) != null) {
      tabsRouter.setActiveIndex(0);
      return;
    }
    if (res?.error?.fields?.keys.firstWhereOrNull((e) => vehicleInfoErrorFields.contains(e)) != null) {
      tabsRouter.setActiveIndex(1);
      return;
    }
    if (res?.error?.fields?.keys.firstWhereOrNull((e) => priceInfoErrorFields.contains(e)) != null) {
      tabsRouter.setActiveIndex(1);
      return;
    }
  }
}
