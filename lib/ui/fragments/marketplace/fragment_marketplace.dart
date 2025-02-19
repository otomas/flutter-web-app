import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/enums/enum_app.dart';
import '../../../core/extensions/extension_balance.dart';
import '../../../core/models/response/model_response_marketplace.dart';
import '../../../core/resources/_r.dart';
import '../../base/base_view.dart';
import '../../widgets/widget_button.dart';
import '../../widgets/widget_image.dart';
import '../../widgets/widget_page_style.dart';
import '../../widgets/widget_scroll.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_marketplace.dart';

@RoutePage()
class FragmentMarketPlace extends StatefulWidget {
  const FragmentMarketPlace({
    this.onChangedFilters,
    super.key,
    @QueryParam('vehicleTypeId') this.vehicleTypeId,
    @QueryParam('vehicleBrandId') this.vehicleBrandId,
    @QueryParam('vehicleSeriesId') this.vehicleSeriesId,
    @QueryParam('vehicleModelId') this.vehicleModelId,
    @QueryParam('vehicleVersionId') this.vehicleVersionId,
    @QueryParam('provinceId') this.provinceId,
    @QueryParam('districtId') this.districtId,
    @QueryParam('minPrice') this.minPrice,
    @QueryParam('maxPrice') this.maxPrice,
    @QueryParam('minKm') this.minKm,
    @QueryParam('maxKm') this.maxKm,
    @QueryParam('minYear') this.minYear,
    @QueryParam('maxYear') this.maxYear,
    @QueryParam('fuelTypes') this.fuelTypes,
    @QueryParam('transmissionTypes') this.transmissionTypes,
    @QueryParam('bodyTypes') this.bodyTypes,
    @QueryParam('enginePowers') this.enginePowers,
    @QueryParam('engineCapacities') this.engineCapacities,
    @QueryParam('tractionTypes') this.tractionTypes,
    @QueryParam('date') this.date,
  });

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
  State<FragmentMarketPlace> createState() => _FragmentMarketPlaceState();
}

class _FragmentMarketPlaceState extends WidgetBaseStatefull<FragmentMarketPlace, VmFragmentMarketPlace> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentMarketPlace createViewModel(BuildContext context) => VmFragmentMarketPlace(
        apiService(context),
        widget.vehicleTypeId,
        widget.vehicleBrandId,
        widget.vehicleSeriesId,
        widget.vehicleModelId,
        widget.vehicleVersionId,
        widget.provinceId,
        widget.districtId,
        widget.minPrice,
        widget.maxPrice,
        widget.minKm,
        widget.maxKm,
        widget.minYear,
        widget.maxYear,
        widget.fuelTypes,
        widget.transmissionTypes,
        widget.bodyTypes,
        widget.enginePowers,
        widget.engineCapacities,
        widget.tractionTypes,
        widget.date,
        widget.onChangedFilters,
      );

  @override
  Widget buildWidget(BuildContext context, VmFragmentMarketPlace viewModel) => ScrollWithNoGlowWidget(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: TextBasic(text: 'İç Pazar Yeri İlanları', color: R.themeColor.smokeDark, fontFamily: R.fonts.displayBold, fontSize: 18)),
                const SizedBox(width: 12),
                if (isWeb(context))
                  WidgetPageStyle(
                    selectedPageStyle: viewModel.pageStyle,
                    onPressedPageStyle: viewModel.onChangedPageStyle,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            _getFilterBar(context, viewModel),
            if (viewModel.pageStyle == PageStyle.twoBox)
              _getGridList(context, viewModel, 2)
            else if (viewModel.pageStyle == PageStyle.threeBox)
              _getGridList(context, viewModel, 3)
            else if (viewModel.pageStyle == PageStyle.verticalBox)
              _getVerticalList(context, viewModel),
          ],
        ),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentMarketPlace viewModel) => buildWidget(context, viewModel);

  Widget _getFilterBar(BuildContext context, VmFragmentMarketPlace viewModel) => ScrollWithNoGlowWidget(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        scrollDirection: Axis.horizontal,
        child: Wrap(
          children: [
            // if (viewModel.data?.filters?.vehicleType != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.vehicleType?.name ?? '', onPressed: () {}),
            if (viewModel.data?.filters?.vehicleBrand != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.vehicleBrand?.name ?? '', onPressed: () {}),
            if (viewModel.data?.filters?.vehicleSeries != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.vehicleSeries?.name ?? '', onPressed: () {}),
            if (viewModel.data?.filters?.vehicleModel != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.vehicleModel?.name ?? '', onPressed: () {}),
            if (viewModel.data?.filters?.vehicleVersion != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.vehicleVersion?.name ?? '', onPressed: () {}),
            if (viewModel.data?.filters?.province != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.province?.name ?? '', onPressed: () {}),
            if (viewModel.data?.filters?.district != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.district?.name ?? '', onPressed: () {}),
            // if (viewModel.data?.filters?.minYear != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.minYear?.name ?? '', onPressed: () {}),
            // if (viewModel.data?.filters?.maxYear != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.maxYear?.name ?? '', onPressed: () {}),
            // if (viewModel.data?.filters?.minPrice != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.minPrice?.name ?? '', onPressed: () {}),
            // if (viewModel.data?.filters?.maxPrice != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.maxPrice?.name ?? '', onPressed: () {}),
            // if (viewModel.data?.filters?.minKm != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.minKm?.name ?? '', onPressed: () {}),
            // if (viewModel.data?.filters?.maxKm != null) WidgetFilterRemoveButton(title: viewModel.data?.filters?.maxPmaxKmrice?.name ?? '', onPressed: () {}),
            if (viewModel.data?.filters?.fuelTypes != null) ...List.generate(viewModel.data?.filters?.fuelTypes?.length ?? 0, (i) => WidgetFilterRemoveButton(title: viewModel.data?.filters?.fuelTypes?[i].name ?? '', onPressed: () {})),
            if (viewModel.data?.filters?.transmissionTypes != null)
              ...List.generate(viewModel.data?.filters?.transmissionTypes?.length ?? 0, (i) => WidgetFilterRemoveButton(title: viewModel.data?.filters?.transmissionTypes?[i].name ?? '', onPressed: () {})),
            if (viewModel.data?.filters?.bodyTypes != null) ...List.generate(viewModel.data?.filters?.bodyTypes?.length ?? 0, (i) => WidgetFilterRemoveButton(title: viewModel.data?.filters?.bodyTypes?[i].name ?? '', onPressed: () {})),
            // if (viewModel.data?.filters?.enginePowers != null) ...List.generate(viewModel.data?.filters?.enginePowers?.length ?? 0, (i) => WidgetFilterRemoveButton(title: viewModel.data?.filters?.enginePowers?[i].name ?? '', onPressed: () {})),
            // if (viewModel.data?.filters?.engineCapacity != null) ...List.generate(viewModel.data?.filters?.engineCapacity?.length ?? 0, (i) => WidgetFilterRemoveButton(title: viewModel.data?.filters?.engineCapacity?[i].name ?? '', onPressed: () {})),
            if (viewModel.data?.filters?.tractionTypes != null) ...List.generate(viewModel.data?.filters?.tractionTypes?.length ?? 0, (i) => WidgetFilterRemoveButton(title: viewModel.data?.filters?.tractionTypes?[i].name ?? '', onPressed: () {})),
            // if (viewModel.data?.filters?.dates != null) ...List.generate(viewModel.data?.filters?.dates?.length ?? 0, (i) => WidgetFilterRemoveButton(title: viewModel.data?.filters?.dates?[i].name ?? '', onPressed: () {})),
          ],
        ),
      );

  Widget _getGridList(BuildContext context, VmFragmentMarketPlace viewModel, int gridCount) => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: gridCount,
        children: List.generate(viewModel.data?.ads?.length ?? 0, (index) {
          final item = viewModel.data!.ads![index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: R.themeColor.borderLight),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: NetworkImageWithPlaceholder(height: double.infinity, width: double.infinity, radius: 12, imageUrl: item.coverPhotoUrl)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TextBasic(
                  text: item.vehicleVersion?.brandModelVersion ?? '',
                  color: R.themeColor.smokeDark,
                  fontFamily: R.fonts.displayBold,
                  fontSize: 14,
                ),
                const SizedBox(height: 12),
                TextBasic(
                  text: item.shortInfo,
                  color: R.themeColor.secondaryHover,
                  fontFamily: R.fonts.displayMedium,
                  fontSize: 14,
                ),
                const SizedBox(height: 12),
                _getPriceBox(item),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _getAutoGalleryBrancInfo(item),
                    const Expanded(child: SizedBox()),
                    _getLocationText(item),
                  ],
                ),
              ],
            ),
          );
        }),
      );

  Widget _getVerticalList(BuildContext context, VmFragmentMarketPlace viewModel) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.data?.ads?.length ?? 0,
        itemBuilder: (context, index) {
          final item = viewModel.data!.ads![index];
          return InkWell(
            onTap: () {},
            focusColor: R.color.transparent,
            hoverColor: R.color.transparent,
            splashColor: R.color.transparent,
            highlightColor: R.color.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(color: R.themeColor.borderLight), borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  NetworkImageWithPlaceholder(height: 160, width: 315, radius: 12, imageUrl: item.coverPhotoUrl),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBasic(
                          text: item.vehicleVersion?.brandModelVersion ?? '',
                          color: R.themeColor.smokeDark,
                          fontFamily: R.fonts.displayBold,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                        TextBasic(
                          text: item.shortInfo,
                          color: R.themeColor.secondaryHover,
                          fontFamily: R.fonts.displayMedium,
                          fontSize: 14,
                        ),
                        const SizedBox(height: 10),
                        _getLocationText(item),
                        const SizedBox(height: 10),
                        _getAutoGalleryBrancInfo(item),
                        if (!isWeb(context)) ...[const SizedBox(height: 10), _getPriceBox(item)],
                      ],
                    ),
                  ),
                  if (isWeb(context)) ...[const SizedBox(width: 12), _getPriceBox(item)],
                ],
              ),
            ),
          );
        },
      );

  Widget _getPriceBox(ModelMarketplaceAds item) => TextBasic(
        text: item.priceDomestic.formatPrice(),
        color: R.themeColor.smokeDark,
        fontFamily: R.fonts.displayBold,
        fontSize: 20,
      );

  Widget _getLocationText(ModelMarketplaceAds item) => WidgetLocationText(
        city: item.autoGalleryBranch?.neighborhood?.district?.province?.name ?? '',
        district: item.autoGalleryBranch?.neighborhood?.district?.name ?? '',
      );

  Widget _getAutoGalleryBrancInfo(ModelMarketplaceAds item) => Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: R.themeColor.primaryLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextBasic(
          text: item.autoGalleryBranch?.name ?? '',
          color: R.themeColor.primary,
          fontFamily: R.fonts.displayMedium,
          fontSize: 14,
        ),
      );
}
