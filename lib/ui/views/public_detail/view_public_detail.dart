// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ucg_interactable_svg/interactable_svg/src/widgets/interactable_svg.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/extensions/extension_balance.dart';
import '../../../core/extensions/extension_date.dart';
import '../../../core/extensions/extension_iterable.dart';
import '../../../core/extensions/extension_num.dart';
import '../../../core/resources/_r.dart';
import '../../../core/utils/general_data.dart';
import '../../../core/utils/vehicle_svg.dart';
import '../../base/base_view.dart';
import '../../widgets/widget_ad_images.dart';
import '../../widgets/widget_flexible.dart';
import '../../widgets/widget_info_card.dart';
import '../../widgets/widget_info_container.dart';
import '../../widgets/widget_public_new_ads.dart';
import '../../widgets/widget_scroll.dart';
import '../../widgets/widget_vehicle_detail_card.dart';
import '../../widgets/widget_vehicle_equipment_list.dart';
import '../../widgets/widget_vehicle_svg.dart';
import '../../widgets/widget_web.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_public_detail.dart';

@RoutePage()
class ViewPublicDetail extends WidgetBase<VmPublicDetail> {
  const ViewPublicDetail({
    @QueryParam('vehicleId') this.vehicleId,
    super.key,
    super.isActiveLoadingIndicator = true,
  });
  final int? vehicleId;

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmPublicDetail createViewModel(BuildContext context) => VmPublicDetail(vehicleId ?? -1, apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmPublicDetail viewModel) => Scaffold(
        key: viewModel.scaffoldkey,
        appBar: _getAppBar(context, viewModel),
        body: _getBody(context, viewModel),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmPublicDetail viewModel) => Scaffold(
        body: WidgetWebBase(
          child: viewModel.isLoading() ? Container() : _getBody(context, viewModel),
        ),
      );

  Widget _getBody(BuildContext context, VmPublicDetail viewModel) => ScrollWithNoGlowWidget(
        child: Center(
          child: Padding(
            padding: isWeb(context)
                ? EdgeInsets.symmetric(horizontal: size(context).width * 0.06, vertical: 20)
                : const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getVehicleGeneralInfoCard(context, viewModel),
                const SizedBox(height: 10),
                _getScreenTypeVisibilityButton(context, viewModel),
                const SizedBox(height: 30),
                if (viewModel.isGeneralScreenTypeSelected) ...[
                  if (isWeb(context)) _vehicleInfoContainersWeb(context, viewModel) else _vehicleInfoBar(context, viewModel),
                  const SizedBox(height: 10),
                  IntrinsicHeight(
                    child: WidgetInfoCard(
                      title: viewModel.data?.title ?? '',
                      description: viewModel.data?.description ?? '',
                      bgColor: R.themeColor.boxBg,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _getVehicleExpertiseReportContainer(context, viewModel),
                  const SizedBox(height: 10),
                  Visibility(visible: viewModel.vehicleEquipments['internal']!.isNotEmpty, child: _internalEquipmentList(context, viewModel)),
                  const SizedBox(height: 10),
                  Visibility(visible: viewModel.vehicleEquipments['external']!.isNotEmpty, child: _externalEquipmentList(context, viewModel)),
                  const SizedBox(height: 10),
                  Visibility(visible: viewModel.vehicleEquipments['multimedia']!.isNotEmpty, child: _multimediaEquipmentList(context, viewModel)),
                  const SizedBox(height: 10),
                  Visibility(visible: viewModel.vehicleEquipments['security']!.isNotEmpty, child: _securityEquipmentList(context, viewModel)),
                  const SizedBox(height: 10),
                  if (isWeb(context)) _getSimilarVehicles(context, viewModel),
                  if (isWeb(context)) const SizedBox(height: 10),
                ] else
                  Container(
                    decoration: BoxDecoration(color: R.themeColor.boxBg),
                    width: double.infinity,
                    height: 500,
                    child: const Center(
                      child: TextBasic(text: 'MAP VIEW'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  Widget _getScreenTypeVisibilityButton(BuildContext context, VmPublicDetail viewModel) => Row(
        children: [
          InkWell(
            onTap: () {
              viewModel.changeisGeneralScreenTypeSelected();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 11.5),
              decoration: BoxDecoration(
                color: viewModel.isGeneralScreenTypeSelected ? R.themeColor.highlighted : R.themeColor.boxBg,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
              ),
              child: TextBasic(text: 'Genel Bakış', color: viewModel.isGeneralScreenTypeSelected ? R.color.brown : R.themeColor.secondary, fontSize: 14),
            ),
          ),
          InkWell(
            onTap: () {
              viewModel.changeisGeneralScreenTypeSelected();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 11.5),
              decoration: BoxDecoration(
                color: !viewModel.isGeneralScreenTypeSelected ? R.themeColor.highlighted : R.themeColor.boxBg,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
              ),
              child: TextBasic(text: 'İlan Konumu', color: !viewModel.isGeneralScreenTypeSelected ? R.color.brown : R.themeColor.secondary, fontSize: 14),
            ),
          ),
        ],
      );

  Widget _getVehicleGeneralInfoCard(BuildContext context, VmPublicDetail viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWeb(context))
            SizedBox(
              width: size(context).width - (size(context).width * 0.12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextBasic(
                      text:
                          '${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name} ${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.name} ${viewModel.data?.vehicleVersion?.vehicleModel?.name} ${viewModel.data?.vehicleVersion?.name}',
                      fontSize: 24,
                      color: R.themeColor.secondary,
                      fontFamily: R.fonts.displayBold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.star_border, color: R.themeColor.secondary, size: 15),
                  const SizedBox(width: 5),
                  TextBasic(text: 'Favorilerime Ekle', fontSize: 12, color: R.themeColor.secondary),
                  const SizedBox(width: 20),
                  VerticalDivider(color: R.themeColor.borderLight),
                  const SizedBox(width: 10),
                  Icon(Icons.share, color: R.themeColor.secondary, size: 15),
                  const SizedBox(width: 5),
                  TextBasic(text: 'Paylaş', fontSize: 12, color: R.themeColor.secondary),
                ],
              ),
            ),
          if (isWeb(context)) const SizedBox(height: 10),
          if (isWeb(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (size(context).width - (size(context).width * 0.12 + 30)) / 2,
                  child: WidgetAdImages(
                    data: viewModel.data?.photos ?? [],
                  ),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: (size(context).width - (size(context).width * 0.12 + 30)) / 3,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Expanded(child: TextBasic(text: '')),
                              TextBasic(
                                text: viewModel.data?.priceForeign.formatPrice() ?? '',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: R.themeColor.secondary,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(child: TextBasic(text: '')),
                              Icon(Icons.location_on, color: R.themeColor.error),
                              TextBasic(
                                text:
                                    '${viewModel.data?.autoGalleryBranch?.neighborhood?.name ?? ''} / ${viewModel.data?.autoGalleryBranch?.neighborhood?.district?.name ?? ''} / ${viewModel.data?.autoGalleryBranch?.neighborhood?.district?.province?.name ?? ''}',
                                color: R.themeColor.secondary,
                              ),
                            ],
                          ),
                          WidgetValueText(title: 'İlan Numarası', value: (viewModel.data?.adNumber ?? -1).toString(), valueColor: R.themeColor.error),
                          WidgetValueText(title: 'İlan Tarihi', value: viewModel.data?.createdAt.dayMonthNameYearAndMonth() ?? ''),
                          WidgetValueText(title: 'Marka', value: viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''),
                          WidgetValueText(title: 'Model Yılı', value: viewModel.data?.modelYear?.toString() ?? ''),
                          WidgetValueText(title: 'Model', value: viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''),
                          WidgetValueText(title: 'Yakıt Tipi', value: viewModel.data?.vehicleFuelType?.name ?? ''),
                          WidgetValueText(title: 'Vites Tipi', value: viewModel.data?.vehicleTransmissionType?.name ?? ''),
                          WidgetValueText(title: 'Motor Gücü', value: '${(viewModel.data?.enginePower ?? 0).formatPrice()} hp'),
                          WidgetValueText(title: 'Motor Hacmi', value: '${(viewModel.data?.engineCapacity ?? 0).formatPrice()} cm³'),
                          WidgetValueText(title: 'Renk', value: viewModel.data?.color ?? '', isActiveDivider: !isWeb(context)),
                          WidgetValueText(title: 'Kilometre', value: viewModel.data?.kilometer.formatPrice() ?? '0', isActiveDivider: !isWeb(context)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                _ownerInfoCard(context, viewModel),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: WidgetAdImages(
                      data: viewModel.data?.photos ?? [],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              TextBasic(
                                text: viewModel.data?.priceForeign.formatPrice() ?? '',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: R.themeColor.secondary,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: R.themeColor.error),
                              TextBasic(
                                text:
                                    '${viewModel.data?.autoGalleryBranch?.neighborhood?.name ?? ''} / ${viewModel.data?.autoGalleryBranch?.neighborhood?.district?.name ?? ''} / ${viewModel.data?.autoGalleryBranch?.neighborhood?.district?.province?.name ?? ''}',
                                color: R.themeColor.secondary,
                              ),
                            ],
                          ),
                          WidgetValueText(title: 'İlan Numarası', value: (viewModel.data?.adNumber ?? -1).toString(), valueColor: R.themeColor.error),
                          WidgetValueText(title: 'İlan Tarihi', value: viewModel.data?.createdAt.dayMonthNameYearAndMonth() ?? ''),
                          WidgetValueText(title: 'Marka', value: viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''),
                          WidgetValueText(title: 'Model Yılı', value: viewModel.data?.modelYear?.toString() ?? ''),
                          WidgetValueText(title: 'Model', value: viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''),
                          WidgetValueText(title: 'Yakıt Tipi', value: viewModel.data?.vehicleFuelType?.name ?? ''),
                          WidgetValueText(title: 'Vites Tipi', value: viewModel.data?.vehicleTransmissionType?.name ?? ''),
                          WidgetValueText(title: 'Motor Gücü', value: '${(viewModel.data?.enginePower ?? 0).formatPrice()} hp'),
                          WidgetValueText(title: 'Motor Hacmi', value: '${(viewModel.data?.engineCapacity ?? 0).formatPrice()} cm³'),
                          WidgetValueText(title: 'Renk', value: viewModel.data?.color ?? '', isActiveDivider: !isWeb(context)),
                          WidgetValueText(title: 'Kilometre', value: viewModel.data?.kilometer.formatPrice() ?? '0', isActiveDivider: !isWeb(context)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      );

  Widget _ownerInfoCard(BuildContext context, VmPublicDetail viewModel) => Container(
        padding: const EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.info),
          borderRadius: BorderRadius.circular(12),
        ),
        height: 300,
        width: (size(context).width - (size(context).width * 0.12 + 30)) / 6,
        child: Column(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: R.themeColor.info,
              ),
              child: Center(
                child: TextBasic(
                  text: viewModel.data?.autoGalleryBranch?.autoGallery?.title?.substring(0, 1).toUpperCase() ?? '',
                  fontSize: 34,
                  color: R.color.white,
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextBasic(text: viewModel.data?.autoGalleryBranch?.autoGallery?.title ?? '', fontSize: 14, color: R.themeColor.secondary),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
              decoration: BoxDecoration(
                color: R.themeColor.highlighted,
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextBasic(
                text: viewModel.data?.autoGalleryBranch?.autoGallery?.accountType?.name ?? '',
                fontSize: 12,
                color: R.themeColor.secondary,
                fontFamily: R.fonts.displayBold,
              ),
            ),
            const SizedBox(height: 15),
            TextBasic(text: viewModel.data?.autoGalleryBranch?.autoGallery?.email ?? '', fontSize: 12, color: R.themeColor.secondary),
            const SizedBox(height: 12.5),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: R.themeColor.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: TextBasic(text: 'Takip Et', fontSize: 12, color: R.themeColor.primary, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    Icon(CupertinoIcons.add, color: R.themeColor.primary),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _getVehicleExpertiseReportContainer(BuildContext context, VmPublicDetail viewModel) => SizedBox(
        width: size(context).width - (size(context).width * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBasic(text: 'Ekspertiz Raporu', fontSize: 18, color: R.themeColor.primary, fontWeight: FontWeight.bold),
                GestureDetector(
                  onTap: () {
                    viewModel.changeisExpertiseContainerVisible();
                  },
                  child: Icon(
                    viewModel.isExpertiseContainerVisible ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus,
                    color: R.themeColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: !viewModel.isExpertiseContainerVisible ? Container() : _getVehicleExpertiseReport(context, viewModel),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );

  Widget _getVehicleExpertiseReport(BuildContext context, VmPublicDetail viewModel) => WidgetVehicleDetailCard(
        title: '',
        children: [
          IntrinsicHeight(
            child: WidgetFlexible(
              isRow: isWeb(context),
              children: [
                UcgInteractableSvg(
                  key: ValueKey(viewModel.data),
                  svgAddress: vehicleSvg,
                  isActivePadding: false,
                  unSelectableColor: (partId, color) {
                    final item = viewModel.expertiseItems.entries.firstWhereOrNull((e) => e.key.id == partId);
                    if (item != null) {
                      return Color(int.tryParse('0xFF${item.value.color}')!);
                    }
                    return null;
                  },
                  onChanged: (region) {},
                ),
                const SizedBox(width: 20),
                if (isWeb(context)) VerticalDivider(color: R.themeColor.borderLight) else Divider(color: R.themeColor.borderLight),
                const SizedBox(width: 20),
                Expanded(
                  child: WidgetExpertiseLabel(
                    vehicleColorFlawGroups: viewModel.colorFlawGroups,
                    selectedItems: viewModel.expertiseItems,
                  ),
                ),
                const SizedBox(width: 20),
                VerticalDivider(color: R.themeColor.borderLight),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBasic(text: 'Ekspertiz Raporu', color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayBold, fontSize: 18),
                      const SizedBox(height: 10),
                      TextBasic(
                        text:
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the.",
                        color: R.themeColor.secondaryHover,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _vehicleInfoContainersWeb(BuildContext context, VmPublicDetail viewModel) => SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 50)) / 6,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoContainer(title: 'Yıl', description: viewModel.data?.modelYear ?? ''),
            ),
            const SizedBox(width: 10),
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 50)) / 6,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoContainer(title: 'Kilometre', description: viewModel.data?.kilometer.toString() ?? ''),
            ),
            const SizedBox(width: 10),
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 50)) / 6,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoContainer(title: 'Vites', description: viewModel.data?.vehicleTransmissionType?.name ?? ''),
            ),
            const SizedBox(width: 10),
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 50)) / 6,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoContainer(title: 'Yakıt Tipi', description: viewModel.data?.vehicleFuelType?.name ?? ''),
            ),
            const SizedBox(width: 10),
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 50)) / 6,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoContainer(title: 'Çekiş Türü', description: viewModel.data?.vehicleTractionType?.name ?? ''),
            ),
            const SizedBox(width: 10),
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 50)) / 6,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoContainer(title: 'Motor', description: ((viewModel.data?.engineCapacity ?? 100) / 100).toStringAsFixed(1)),
            ),
          ],
        ),
      );

  Widget _vehicleInfoContainers(BuildContext context, VmPublicDetail viewModel) => Column(
        children: [
          Row(
            children: [
              Container(
                width: (size(context).width - 50) / 3,
                decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
                child: WidgetInfoContainer(title: 'Yıl', description: viewModel.data?.modelYear ?? ''),
              ),
              const SizedBox(width: 10),
              Container(
                width: (size(context).width - 50) / 3,
                decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
                child: WidgetInfoContainer(title: 'Kilometre', description: viewModel.data?.kilometer.toString() ?? ''),
              ),
              const SizedBox(width: 10),
              Container(
                width: (size(context).width - 50) / 3,
                decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
                child: WidgetInfoContainer(title: 'Vites', description: viewModel.data?.vehicleTransmissionType?.name ?? ''),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: (size(context).width - 50) / 3,
                decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
                child: WidgetInfoContainer(title: 'Yakıt Tipi', description: viewModel.data?.vehicleFuelType?.name ?? ''),
              ),
              const SizedBox(width: 10),
              Container(
                width: (size(context).width - 50) / 3,
                decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
                child: WidgetInfoContainer(title: 'Çekiş Türü', description: viewModel.data?.vehicleTractionType?.name ?? ''),
              ),
              const SizedBox(width: 10),
              Container(
                width: (size(context).width - 50) / 3,
                decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
                child: WidgetInfoContainer(title: 'Motor', description: ((viewModel.data?.engineCapacity ?? 100) / 100).toStringAsFixed(1)),
              ),
            ],
          ),
        ],
      );

  Widget _vehicleInfoBar(BuildContext context, VmPublicDetail viewModel) => SizedBox(
        width: size(context).width - 30,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBasic(text: 'Aracın Öne Çıkan Özellikleri', fontSize: 18, color: R.themeColor.primary, fontWeight: FontWeight.bold),
                GestureDetector(
                  onTap: () {
                    viewModel.changeisVehicleInfoVisible();
                  },
                  child: Icon(
                    viewModel.isVehicleInfoVisible ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus,
                    color: R.themeColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: !viewModel.isVehicleInfoVisible ? Container() : _vehicleInfoContainers(context, viewModel),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );

  Widget _internalEquipmentList(BuildContext context, VmPublicDetail viewModel) => SizedBox(
        width: size(context).width - (size(context).width * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBasic(text: 'İç Donanım', fontSize: 18, color: R.themeColor.secondary, fontWeight: FontWeight.bold),
                GestureDetector(
                  onTap: () {
                    viewModel.changeisInternalEquipmentVisible();
                  },
                  child: Icon(
                    viewModel.isInternalEquipmentVisible ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus,
                    color: R.themeColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: !viewModel.isInternalEquipmentVisible ? Container() : _internalEquipmentListContainer(context, viewModel),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );

  Widget _internalEquipmentListContainer(BuildContext context, VmPublicDetail viewModel) => Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: WidgetVehicleEquipmentList(items: viewModel.vehicleEquipments['internal'] ?? []),
      );

  Widget _multimediaEquipmentListContainer(BuildContext context, VmPublicDetail viewModel) => Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: WidgetVehicleEquipmentList(items: viewModel.vehicleEquipments['multimedia'] ?? []),
      );

  Widget _multimediaEquipmentList(BuildContext context, VmPublicDetail viewModel) => SizedBox(
        width: size(context).width - (size(context).width * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBasic(text: 'Multimedya', fontSize: 18, color: R.themeColor.secondary, fontWeight: FontWeight.bold),
                GestureDetector(
                  onTap: () {
                    viewModel.changeisMultimediaEquipmentVisible();
                  },
                  child: Icon(
                    viewModel.isMultimediaEquipmentVisible ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus,
                    color: R.themeColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: !viewModel.isMultimediaEquipmentVisible ? Container() : _multimediaEquipmentListContainer(context, viewModel),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );

  Widget _securityEquipmentListContainer(BuildContext context, VmPublicDetail viewModel) => Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: WidgetVehicleEquipmentList(items: viewModel.vehicleEquipments['security'] ?? []),
      );

  Widget _securityEquipmentList(BuildContext context, VmPublicDetail viewModel) => SizedBox(
        width: size(context).width - (size(context).width * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBasic(text: 'Güvenlik', fontSize: 18, color: R.themeColor.secondary, fontWeight: FontWeight.bold),
                GestureDetector(
                  onTap: () {
                    viewModel.changeisSecurityEquipmentVisible();
                  },
                  child: Icon(
                    viewModel.isSecurityEquipmentVisible ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus,
                    color: R.themeColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: !viewModel.isSecurityEquipmentVisible ? Container() : _securityEquipmentListContainer(context, viewModel),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );

  Widget _externalEquipmentList(BuildContext context, VmPublicDetail viewModel) => SizedBox(
        width: size(context).width - (size(context).width * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBasic(text: 'Dış Donanım', fontSize: 18, color: R.themeColor.secondary, fontWeight: FontWeight.bold),
                GestureDetector(
                  onTap: () {
                    viewModel.changeisExternalEquipmentVisible();
                  },
                  child: Icon(
                    viewModel.isExternalEquipmentVisible ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus,
                    color: R.themeColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: !viewModel.isExternalEquipmentVisible ? Container() : _externalEquipmentListContainer(context, viewModel),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );

  Widget _externalEquipmentListContainer(BuildContext context, VmPublicDetail viewModel) => Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: WidgetVehicleEquipmentList(items: viewModel.vehicleEquipments['external'] ?? []),
      );

  Widget _getSimilarVehicles(BuildContext context, VmPublicDetail viewModel) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBasic(text: 'Benzer Araçlar', fontSize: 18, fontWeight: FontWeight.bold, color: R.color.black),
              Row(
                children: [
                  TextBasic(text: 'Tümünü Gör', fontSize: 12, color: R.themeColor.secondary, fontWeight: FontWeight.bold),
                  const SizedBox(width: 5),
                  Icon(CupertinoIcons.arrow_right, color: R.themeColor.secondary, size: 12),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const WidgetPublicNewAds(),
          const SizedBox(height: 20),
        ],
      );

  AppBar _getAppBar(BuildContext context, VmPublicDetail viewModel) => AppBar(
        centerTitle: false,
        backgroundColor: R.color.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBasic(text: R.string.hello, color: R.themeColor.smoke, fontFamily: R.fonts.displayMedium, fontSize: 12),
                  TextBasic(
                    text: GeneralData.getInstance().getTokenData()?.fullName ?? '-',
                    color: R.themeColor.secondaryHover,
                    fontFamily: R.fonts.displayBold,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                R.drawable.svg.iconChat,
                colorFilter: ColorFilter.mode(R.themeColor.secondary, BlendMode.srcIn),
                width: 26,
              ),
            ),
            const SizedBox(width: 10),
            // IconButton(
            //   onPressed: () {},
            //   icon: SvgPicture.asset(
            //     R.drawable.svg.iconDate,
            //     colorFilter: ColorFilter.mode(R.themeColor.secondary, BlendMode.srcIn),
            //     width: 26.0,
            //   ),
            // ),
            // const SizedBox(width: 10.0),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                R.drawable.svg.iconNotification,
                colorFilter: ColorFilter.mode(R.themeColor.secondary, BlendMode.srcIn),
                width: 26,
              ),
            ),
          ],
        ),
      );
}
