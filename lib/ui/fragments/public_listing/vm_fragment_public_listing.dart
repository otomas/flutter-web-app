import 'dart:async';

import '../../../core/enums/enum_app.dart';
import '../../../core/models/request/model_request_filter_marketplace.dart';
import '../../../core/models/response/model_response_marketplace.dart';
import '../../../core/models/response/model_response_public_vehicle_list.dart';
import '../../../core/services/service_api.dart';
import '../../base/base_view_model.dart';

class VmFragmentPublicListing extends ViewModelBase {
  VmFragmentPublicListing(
    this.serviceApi,
    this.vehicleTypeId,
    this.vehicleBrandId,
    this.vehicleSeriesId,
    this.vehicleModelId,
    this.vehicleVersionId,
    this.provinceId,
    this.districtId,
    this.minPrice,
    this.maxPrice,
    this.minKm,
    this.maxKm,
    this.minYear,
    this.maxYear,
    this.fuelTypes,
    this.transmissionTypes,
    this.bodyTypes,
    this.enginePowers,
    this.engineCapacities,
    this.tractionTypes,
    this.date,
    this.onChangedFilters,
  ) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  PageStyle pageStyle = PageStyle.verticalBox;

  ModelPublicVehicleListResponse? data;

  final int? vehicleTypeId;
  final int? vehicleBrandId;
  final int? vehicleSeriesId;
  final int? vehicleModelId;
  final int? vehicleVersionId;
  final int? provinceId;
  final int? districtId;
  final num? minPrice;
  final num? maxPrice;
  final num? minKm;
  final num? maxKm;
  final int? minYear;
  final int? maxYear;
  final List<String>? fuelTypes;
  final List<String>? transmissionTypes;
  final List<String>? bodyTypes;
  final List<String>? enginePowers;
  final List<String>? engineCapacities;
  final List<String>? tractionTypes;
  final List<String>? date;
  final Function(ModelMarketplaceResponseFilter? appliedFilters)? onChangedFilters;

  @override
  Future<void> init() async {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client
        .getPublicVehicleList(
      ModelRequestFilterMarketplace(
        filters: ModelFilterMarketplaceRequest(
          vehicleBrandId: vehicleBrandId,
          bodyType: bodyTypes?.map(int.parse).toList(),
          vehicleSeriesId: vehicleSeriesId,
          // date: date,
          provinceId: provinceId,
          districtId: districtId,
          engineCapacity: engineCapacities,
          enginePower: enginePowers,
          fuelType: fuelTypes?.map(int.parse).toList(),
          price: (maxPrice ?? -1) > 0 && (minPrice ?? -1) > 0 ? ModelMinMax(max: maxPrice?.toInt().toString(), min: minPrice?.toString()) : null,
          tractionType: tractionTypes?.map(int.parse).toList(),
          transmissionType: transmissionTypes?.map(int.parse).toList(),
          vehicleModelId: vehicleModelId,
          year: ModelMinMax(max: maxYear?.toString(), min: minYear?.toString()),
        ),
      ),
    )
        .then(
      (response) {
        data = response.data;
        onChangedFilters?.call(data?.filters);
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  void onChangedPageStyle(PageStyle style) {
    pageStyle = style;
    notifyListeners();
  }
}
