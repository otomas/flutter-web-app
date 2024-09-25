import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/enum_app.dart';
import '../../../../core/models/model_router_destinition.dart';
import '../../../../core/models/request/model_request_publish_ad.dart';
import '../../../../core/models/response/model_response_vehicle_status.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/services/router/router.gr.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmVehicleDetail extends ViewModelBase {
  VmVehicleDetail(this.serviceApi, this.id, this.branchId) {
    init();
  }

  final int id;
  final int? branchId;

  final ServiceApi serviceApi;

  final List<RouteDestination> fragments = [];

  TabsRouter? tabsRouter;
  void setTabsRouter(TabsRouter r) => tabsRouter = r;

  ModelVehicleStatus? vehicleStatus;

  ValueNotifier<bool> isPublishPriceDomestic = ValueNotifier<bool>(false);
  ValueNotifier<bool> isPublishPriceForeign = ValueNotifier<bool>(false);

  @override
  void init() {
    fragments
      ..clear()
      ..add(RouteDestination(route: FragmentVehicleDetailInfo(branchId: branchId), iconSvgPath: R.drawable.svg.iconInfo, label: 'Araç Bilgileri'))
      ..add(RouteDestination(route: FragmentVehicleDetailAdInfo(branchId: branchId), iconSvgPath: R.drawable.svg.iconMarketPlace, label: 'İlan Bilgileri'))
      ..add(RouteDestination(route: FragmentVehicleDetailInfoCard(branchId: branchId), iconSvgPath: R.drawable.svg.iconVehicleInfoCard, label: 'Araç Bilgi Kartı'))
      ..add(RouteDestination(route: FragmentVehicleDetailQueryDamage(branchId: branchId), iconSvgPath: R.drawable.svg.iconSearch, label: 'Hasar Kaydı'))
      ..add(RouteDestination(route: FragmentVehicleDetailQueryPartChange(branchId: branchId), iconSvgPath: R.drawable.svg.iconSearch, label: 'Parça Değişim Kaydı'))
      ..add(RouteDestination(route: FragmentVehicleDetailQueryKilometer(branchId: branchId), iconSvgPath: R.drawable.svg.iconSearch, label: 'Kilometre Kaydı'));

    unawaited(getVehicleStatus());
  }

  void setSelectedPageIndex(int index) {
    tabsRouter?.setActiveIndex(index);
  }

  void setIsPublishPriceDomestic(bool? value) {
    isPublishPriceDomestic.value = !(vehicleStatus?.isPublishPriceDomestic ?? false);
  }

  void setIsPublishPriceForeign(bool? value) {
    isPublishPriceForeign.value = !(vehicleStatus?.isPublishPriceForeign ?? false);
  }

  Future<void> getVehicleStatus() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getVehicleStatus(id).then(
      (response) {
        vehicleStatus = response.data;
        isPublishPriceDomestic.value = vehicleStatus?.isPublishPriceDomestic ?? false;
        isPublishPriceForeign.value = vehicleStatus?.isPublishPriceForeign ?? false;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  Future<bool> publishAdd() async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.publishAdd(id, ModelRequestPublishAd(isPublishPriceDomestic: isPublishPriceDomestic.value ? 1 : 0, isPublishPriceForeign: isPublishPriceForeign.value ? 1 : 0)).then(
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
  
  Future<bool> updatePublishedAdd() async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.updatePublishedAdd(id, ModelRequestPublishAd(isPublishPriceDomestic: isPublishPriceDomestic.value ? 1 : 0, isPublishPriceForeign: isPublishPriceForeign.value ? 1 : 0)).then(
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

  Future<bool> archiveVehicle([bool isRecovery = false]) async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.archiveVehicle(id, isRecovery).then(
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
