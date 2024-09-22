import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/ui_brightness_style.dart';
import '../../../core/resources/_r.dart';
import '../../../core/services/router/router.gr.dart';
import '../../base/base_view.dart';
import '../../bs/bs_filter_marketplace.dart';
import '../../widgets/widget_app_bar.dart';
import '../../widgets/widget_web.dart';
import 'vm_marketplace.dart';

@RoutePage()
class ViewMarketPlace extends WidgetBase<VmMarketplace> {
  const ViewMarketPlace({
    super.key,
    super.isActiveLoadingIndicator = true,
    this.vehicleId,
    this.branchId,
  });
  final int? vehicleId;
  final int? branchId;

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmMarketplace createViewModel(BuildContext context) => VmMarketplace(apiService(context), router(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmMarketplace viewModel) => Scaffold(
        body: WidgetWebBase(
          child: Padding(
            padding: EdgeInsets.fromLTRB(size(context).width * 0.06, 20, 20, 0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _getFilterBox(context, viewModel),
                ),
                Expanded(
                  flex: 8,
                  child: _getAutoTabsRouter(context, viewModel),
                ),
              ],
            ),
          ),
        ),
      );
  @override
  Widget buildWidget(BuildContext context, VmMarketplace viewModel) => Scaffold(
        appBar: WidgetAppBarBasic(
          title: 'İç Pazar Yeri İlanları',
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: SvgPicture.asset(R.drawable.svg.iconStar)),
            IconButton(
              onPressed: () {
                unawaited(router(context).showBaseBottomSheet(context, _getFilters(context, viewModel)));
              },
              icon: SvgPicture.asset(R.drawable.svg.iconFilter),
            ),
          ],
        ),
        body: _getAutoTabsRouter(context, viewModel),
      );

  Widget _getAutoTabsRouter(BuildContext context, VmMarketplace viewModel) => AutoTabsRouter(
        routes: [
          FragmentMarketPlace(
            vehicleTypeId: viewModel.filters.vehicleType?.id,
            vehicleBrandId: viewModel.filters.brand?.id,
            vehicleSeriesId: viewModel.filters.serie?.id,
            vehicleModelId: viewModel.filters.model?.id,
            vehicleVersionId: viewModel.filters.version?.id,
            provinceId: viewModel.filters.country?.id,
            districtId: viewModel.filters.city?.id,
            minYear: viewModel.filters.minDate?.year,
            maxYear: viewModel.filters.maxDate?.year,
            minPrice: viewModel.filters.getMinPrice(),
            maxPrice: viewModel.filters.getMaxPrice(),
            minKm: viewModel.filters.getMinKilometer(),
            maxKm: viewModel.filters.getMaxKilometer(),
            fuelTypes: viewModel.filters.fuelTypes.map((e) => e.id.toString()).toList(),
            transmissionTypes: viewModel.filters.transmissionTypes.map((e) => e.id.toString()).toList(),
            bodyTypes: viewModel.filters.bodyTypes.map((e) => e.id.toString()).toList(),
            enginePowers: viewModel.filters.enginePowers.map((e) => e.dropdownId).toList(),
            engineCapacities: viewModel.filters.engineCapacity.map((e) => e.dropdownId).toList(),
            tractionTypes: viewModel.filters.tractionTypes.map((e) => e.dropdownId).toList(),
            date: viewModel.filters.dates.map((e) => e.dropdownId).toList(),
            // onChangedFilters: viewModel.onChangedFilters,
          ),
        ],
        builder: (context, child) {
          viewModel.tabsRouter = context.tabsRouter;
          return child;
        },
      );

  Widget 
  _getFilterBox(BuildContext context, VmMarketplace viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: R.themeColor.border),
          ),
          child: _getFilters(context, viewModel),
        ),
      );

  Widget _getFilters(BuildContext context, VmMarketplace viewModel) => BsFiltershowcase(
        key: viewModel.filterKey,
        filter: viewModel.filters,
        onSuccess: (filter) {
          viewModel.updateFilters(filter);
        },
      );
}
