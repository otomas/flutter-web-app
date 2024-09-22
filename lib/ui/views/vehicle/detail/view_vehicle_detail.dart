import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/enums/enum_api.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/models/model_alert_dialog.dart';
import '../../../../core/models/model_vehicle.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/services/router/router.gr.dart';
import '../../../../core/services/service_app.dart';
import '../../../../core/utils/alert_utils.dart';
import '../../../base/base_view.dart';
import '../../../bs/bs_vehicle_sold.dart';
import '../../../widgets/widget_app_bar.dart';
import '../../../widgets/widget_button.dart';
import '../../../widgets/widget_dropdown.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_web.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_vehicle_detail.dart';

@RoutePage()
class ViewVehicleDetail extends WidgetBase<VmVehicleDetail> {
  const ViewVehicleDetail({
    @PathParam('vehicleId') required this.vehicleId,
    @QueryParam('branchId') this.branchId,
    super.key,
    super.isActiveLoadingIndicator = true,
  });
  final int vehicleId;
  final int? branchId;

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmVehicleDetail createViewModel(BuildContext context) => VmVehicleDetail(apiService(context), vehicleId, branchId);

  @override
  Widget buildWidgetForWeb(BuildContext context, VmVehicleDetail viewModel) => _getTabsRouter(
        context,
        viewModel,
        (fragment) => Scaffold(
          backgroundColor: R.themeColor.boxBg,
          body: WidgetWebBase(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTabs(context, viewModel),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: size(context).width * 0.06),
                      Expanded(flex: 8, child: fragment),
                      const SizedBox(width: 30),
                      if (viewModel.vehicleStatus != null)
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.only(top: 40),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: R.themeColor.viewBg,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 34,
                                  color: R.themeColor.viewText.withOpacity(0.24),
                                  offset: const Offset(0, 20),
                                ),
                              ],
                            ),
                            child: Wrap(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBasic(text: 'Araç İşlemleri', color: R.themeColor.smokeDark, fontFamily: R.fonts.displayBold, fontSize: 18),
                                    const SizedBox(height: 20),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (viewModel.vehicleStatus?.status == VehicleStatus.readyForPublication) {
                                                  unawaited(
                                                    showPlatformAlert(
                                                      context,
                                                      ModelAlertDialog(
                                                        dialogType: DialogTypes.confirmation,
                                                        title: 'Aracı yayına alıyorsunuz',
                                                        description: 'Aracı yayına almak istediğinizden emin misiniz?',
                                                        buttonText: 'Yayına Al',
                                                        buttonColor: R.themeColor.highlighted,
                                                        textColor: R.themeColor.text,
                                                        onPressedButton: () async {
                                                          if (!(viewModel.vehicleStatus?.isPublishPriceDomestic ?? false) && !(viewModel.vehicleStatus?.isPublishPriceForeign ?? false)) {
                                                            viewModel.errorObserver.message = 'Lütfen yayınlanacak iç pazar ya da dış pazar seçimi yapın';
                                                          } else if (await viewModel.publishAdd() && context.mounted) {
                                                            viewModel.alertObserver.alert = const ModelAlertDialog(
                                                              dialogType: DialogTypes.success,
                                                              title: 'İlanınız kaydedildi',
                                                              description: 'İlanınız onaylandıktan sonra Pazar yerinde yayınlanacaktır.',
                                                            );
                                                          }
                                                        },
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: _getAdPublishStatus(context, viewModel),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  viewModel.errorObserver.message = 'İlanı yayına almak için lütfen İlan Bilgileri sekmesindeki alanları doldurunuz';
                                                }
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: R.themeColor.successLight,
                                                  borderRadius: BorderRadius.circular(14),
                                                  border: Border.all(color: R.themeColor.success),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(R.drawable.svg.iconZeroWorld, colorFilter: ColorFilter.mode(R.themeColor.success, BlendMode.srcIn), height: 36),
                                                    const SizedBox(height: 8),
                                                    TextBasic(text: 'Aracı\nYayına Al', color: R.themeColor.success, fontFamily: R.fonts.displayBold, fontSize: 14, textAlign: TextAlign.center),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                unawaited(
                                                  router(context).showBaseBottomSheet(
                                                    context,
                                                    BsVehicleSold(
                                                      vehicleId: vehicleId,
                                                      // sellingPrice: viewModel.data?.price,
                                                      onSuccess: () {
                                                        showPlatformAlert(
                                                          context,
                                                          ModelAlertDialog(
                                                            dialogType: DialogTypes.success,
                                                            title: 'Aracınız Satılmıştır, Tebrik Ederiz!',
                                                            description: 'Aracınız başarıyla satıldı. Bu yeni başlangıcınızın size hayırlı olmasını dileriz.',
                                                            onPressedButton: () {
                                                              unawaited(router(context).startNewViewWithPath(route: '/home/vehicles-sold'));
                                                              di<ServiceApp>(context).notify();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(14),
                                                  border: Border.all(color: R.themeColor.border),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(R.drawable.svg.iconKey, colorFilter: ColorFilter.mode(R.themeColor.smokeDark, BlendMode.srcIn), height: 36),
                                                    const SizedBox(height: 8),
                                                    TextBasic(text: 'Aracımı\nSattım', color: R.themeColor.smokeDark, fontFamily: R.fonts.displayBold, fontSize: 14, textAlign: TextAlign.center),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                showToast('Çok yakında');
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(14),
                                                  border: Border.all(color: R.themeColor.border),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(R.drawable.svg.iconCreditOpportunitie, colorFilter: ColorFilter.mode(R.themeColor.smokeDark, BlendMode.srcIn), height: 36),
                                                    const SizedBox(height: 8),
                                                    TextBasic(text: 'Kredi\nTeklifi Al', color: R.themeColor.smokeDark, fontFamily: R.fonts.displayBold, fontSize: 14, textAlign: TextAlign.center),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: R.themeColor.highlightedLight,
                                                borderRadius: BorderRadius.circular(14),
                                                border: Border.all(color: R.themeColor.highlighted),
                                              ),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(R.drawable.svg.iconRocket, colorFilter: ColorFilter.mode(R.themeColor.text, BlendMode.srcIn), height: 36),
                                                  const SizedBox(height: 8),
                                                  TextBasic(text: 'İlanı\nDopingle', color: R.themeColor.text, fontFamily: R.fonts.displayBold, fontSize: 14, textAlign: TextAlign.center),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ..._getAdPublishStatus(context, viewModel),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: R.themeColor.border, width: 2),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: ButtonBasic(
                                              text: 'Düzenle',
                                              bgColor: R.color.transparent,
                                              textColor: R.themeColor.smokeDark,
                                              onPressed: () async {
                                                final result = await router(context).startNewView(route: RouteVehicleCreate(vehicleId: vehicleId, branchId: branchId));
                                                if (result is bool && result && context.mounted) {
                                                  unawaited(router(context).startNewView(route: RouteVehicleDetail(vehicleId: vehicleId, branchId: branchId), isReplace: true));
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: R.themeColor.error,
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.circular(8), // Köşeleri yuvarlamak istersen
                                            ),
                                            child: ButtonBasic(
                                              text: 'Arşivle',
                                              bgColor: R.color.transparent,
                                              textColor: R.themeColor.error,
                                              onPressed: () {
                                                unawaited(
                                                  showPlatformAlert(
                                                    context,
                                                    ModelAlertDialog(
                                                      dialogType: DialogTypes.confirmation,
                                                      title: 'Aracı arşive alıyorsunuz',
                                                      description: 'Aracı arşive almak istediğinize emin misiniz?',
                                                      isActiveCancelButton: true,
                                                      onPressedButton: () async {
                                                        final v = await viewModel.archiveVehicle();
                                                        if (v && context.mounted) {
                                                          unawaited(
                                                            showPlatformAlert(
                                                              context,
                                                              ModelAlertDialog(
                                                                dialogType: DialogTypes.success,
                                                                title: 'Aracınız arşive alınmıştır, Tebrik Ederiz!',
                                                                description: 'Aracınız başarıyla arşive alındı. Bu yeni başlangıcınızın size hayırlı olmasını dileriz.',
                                                                onPressedButton: () {
                                                                  unawaited(router(context).startNewViewWithPath(route: '/home/vehicles-archived'));
                                                                  di<ServiceApp>(context).notify();
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(width: size(context).width * 0.06),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  @override
  Widget buildWidget(BuildContext context, VmVehicleDetail viewModel) => _getTabsRouter(
        context,
        viewModel,
        (fragment) => Scaffold(
          appBar: kIsWeb ? null : const WidgetAppBarBasic(title: 'Araç Detayı'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTabs(context, viewModel),
              Expanded(child: fragment),
            ],
          ),
        ),
      );

  Widget _getTabsRouter(BuildContext context, VmVehicleDetail viewModel, Widget Function(Widget child) child) => AutoTabsRouter(
        routes: viewModel.fragments.map((e) => e.route).toList(),
        builder: (context, fragment) {
          viewModel.setTabsRouter(context.tabsRouter);
          return child(fragment);
        },
      );

  Widget _getTabs(BuildContext context, VmVehicleDetail viewModel) => IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                color: R.themeColor.viewBg,
                padding: const EdgeInsets.only(top: 18),
                child: ScrollWithNoGlowWidget(
                  padding: EdgeInsets.symmetric(horizontal: size(context).width * .06),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      viewModel.fragments.length,
                      (index) {
                        final item = viewModel.fragments[index];
                        return InkWell(
                          onTap: () => viewModel.setSelectedPageIndex(index),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              border: index != viewModel.tabsRouter?.activeIndex ? null : Border(bottom: BorderSide(width: 2, color: R.themeColor.primary)),
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  item.iconSvgPath,
                                  colorFilter: ColorFilter.mode(index == viewModel.tabsRouter?.activeIndex ? R.themeColor.primary : R.color.gray, BlendMode.srcIn),
                                ),
                                const SizedBox(height: 5),
                                TextBasic(
                                  text: item.label,
                                  color: index == viewModel.tabsRouter?.activeIndex ? R.themeColor.primary : R.color.gray,
                                  fontFamily: index == viewModel.tabsRouter?.activeIndex ? R.fonts.displayBold : R.fonts.displayMedium,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (isWeb(context)) Container(width: 30, color: R.themeColor.viewBg),
            if (isWeb(context))
              Expanded(
                flex: 2,
                child: ColoredBox(
                  color: R.themeColor.viewBg,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownBasic(
                        title: 'Araç Seçimi',
                        selectedItem: ModelVehicle(autoGalleryBranchId: branchId ?? 0, id: vehicleId),
                        // ignore: discarded_futures
                        callback: () => apiService(context).client.getVehicles(),
                        onChanged: (v, isAutoComplete) {
                          final newId = int.tryParse(v?.dropdownId ?? '0') ?? 0;
                          if (v != null && newId > 0 && newId != vehicleId) {
                            unawaited(router(context).startNewView(route: RouteVehicleDetail(vehicleId: newId)));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            Container(color: R.themeColor.viewBg, width: size(context).width * 0.06),
          ],
        ),
      );

  List<Widget> _getAdPublishStatus(BuildContext context, VmVehicleDetail viewModel) => [
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          applyCupertinoTheme: true,
          value: viewModel.vehicleStatus!.isPublishPriceDomestic,
          onChanged: viewModel.setIsPublishPriceDomestic,
          title: TextBasic(
            text: 'İç Pazarda Göster',
            color: R.themeColor.smokeDark,
            fontFamily: R.fonts.displayMedium,
            fontSize: 14,
          ),
        ),
        Divider(color: R.themeColor.border),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          applyCupertinoTheme: true,
          value: viewModel.vehicleStatus!.isPublishPriceForeign,
          onChanged: viewModel.setIsPublishPriceForeign,
          title: TextBasic(
            text: 'Dış Pazarda Göster',
            color: R.themeColor.smokeDark,
            fontFamily: R.fonts.displayMedium,
            fontSize: 14,
          ),
        ),
      ];
}
