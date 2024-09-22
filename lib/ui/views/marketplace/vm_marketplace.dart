import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/models/model_filter_marketplace.dart';
import '../../../core/models/model_vehicle_body_type.dart';
import '../../../core/models/model_vehicle_brands.dart';
import '../../../core/models/model_vehicle_type.dart';
import '../../../core/models/response/model_response_marketplace.dart';
import '../../../core/services/router/router.gr.dart';
import '../../../core/services/service_api.dart';
import '../../../core/services/service_route.dart';
import '../../base/base_view_model.dart';

class VmMarketplace extends ViewModelBase {
  VmMarketplace(this.serviceApi, this.serviceRoute) {
    init();
  }

  final ServiceApi serviceApi;
  final ServiceRoute serviceRoute;

  ValueKey filterKey = const ValueKey(0);

  ModelFilterMarketplace filters = ModelFilterMarketplace();

  TabsRouter? tabsRouter;

  @override
  void init() {}

  void updateFilters(ModelFilterMarketplace filter) {
    filters = filter;
    unawaited(
      tabsRouter?.navigate(
        FragmentMarketPlace(
          vehicleTypeId: filter.vehicleType?.id,
          vehicleBrandId: filter.brand?.id,
          vehicleModelId: filter.model?.id,
          vehicleVersionId: filter.version?.id,
          vehicleSeriesId: filter.serie?.id,
          transmissionTypes: filter.transmissionTypes.map((e) => e.id.toString()).toList(),
          fuelTypes: filter.fuelTypes.map((e) => e.id.toString()).toList(),
          bodyTypes: filter.bodyTypes.map((e) => e.id.toString()).toList(),
          minYear: filter.minDate?.year,
          maxYear: filter.maxDate?.year,
          date: filter.dates.map((e) => e.label!).toList(),
          provinceId: filter.country?.id,
          districtId: filter.city?.id,
          engineCapacities: filter.engineCapacity.map((e) => e.value!).toList(),
          enginePowers: filter.enginePowers.map((e) => e.value!).toList(),
          minPrice: filter.getMinPrice(),
          maxPrice: filter.getMaxPrice(),
          tractionTypes: filter.tractionTypes.map((e) => e.id.toString()).toList(),
          minKm: filter.getMinKilometer(),
          maxKm: filter.getMaxKilometer(),
          onChangedFilters: onChangedFilters,
        ),
        onFailure: (failure) {
          log('message');
        },
      ),
    );
    tabsRouter?.notifyAll(forceUrlRebuild: true);
    filterKey = ValueKey(DateTime.now().toIso8601String());
    notifyListeners();
  }

  void onChangedFilters(ModelMarketplaceResponseFilter? filters) {
    this.filters.vehicleType = 1 == 1 ? null : const ModelVehicleType(id: 1);
    this.filters.brand = filters?.vehicleBrand == null ? null : ModelVehicleBrand(id: filters!.vehicleBrand!.id!);
    this.filters.bodyTypes = filters?.bodyTypes?.map((e) => ModelVehicleBodyType(id: e.id!)).toList() ?? [];
    notifyListeners();
  }
}
