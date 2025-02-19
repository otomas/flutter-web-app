// ignore_for_file: avoid_field_initializers_in_const_classes

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/resources/_r.dart';
import '../../../core/services/router/router.gr.dart' as routergr;
import '../../base/base_view.dart';
import '../../widgets/widget_home_feature_selection.dart';
import '../../widgets/widget_info_card.dart';
import '../../widgets/widget_public_new_ads.dart';
import '../../widgets/widget_public_vehicle_info_bar.dart';
import '../../widgets/widget_scroll.dart';
import '../../widgets/widget_web.dart';
import '../../widgets/widgets_text.dart';
import 'vm_public.home.dart';

@RoutePage()
class ViewPublicHome extends WidgetBase<VmPublicHome> {
  const ViewPublicHome({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmPublicHome createViewModel(BuildContext context) => VmPublicHome(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmPublicHome viewModel) => const Center(child: Text('Public'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmPublicHome viewModel) => Scaffold(
        body: WidgetWebBase(
          child: _getBody(context, viewModel),
        ),
      );

  Widget _getBody(BuildContext context, VmPublicHome viewModel) => ScrollWithNoGlowWidget(
        child: Column(
          children: [
            Container(
              width: size(context).width,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(color: R.themeColor.boxBg),
              child: const Center(child: WidgetPublicVehicleInfoBar()),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size(context).width * 0.06, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBasic(text: 'Bölgenizde eklenmiş yeni ilanlar', fontSize: 18, fontWeight: FontWeight.bold, color: R.color.black),
                          InkWell(
                            onTap: () async => unawaited(
                              router(context).startNewView(
                                route: routergr.RoutePublicDetail(),
                                isReplace: true,
                              ),
                            ),
                            child: Row(
                              children: [
                                TextBasic(text: 'Tümünü Gör', fontSize: 12, color: R.themeColor.secondary, fontWeight: FontWeight.bold),
                                const SizedBox(width: 5),
                                Icon(CupertinoIcons.arrow_right, color: R.themeColor.secondary, size: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const WidgetPublicNewAds(),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: size(context).width - (size(context).width * 0.06 + 35),
                      child: WidgetInfoCard(
                        title: 'Üyelik paketlerimizi incelediniz mi?',
                        description: 'Size en uygun çözümleri sunmak için farklı ihtiyaçlara yönelik çeşitli üyelik paketlerimi hazırladık.',
                        startColor: R.themeColor.primaryLight,
                        endColor: R.themeColor.successLight,
                        iconColor: R.themeColor.smoke,
                        onButtonAction: () => {},
                        buttonText: 'Şimdi Keşfet',
                      ),
                    ),
                    const SizedBox(height: 20),
                    _vehicleFeatureSelection(context, viewModel),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: size(context).width - (size(context).width * 0.06 + 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBasic(text: 'Araç Kiralama Avantajları', fontSize: 18, fontFamily: R.fonts.displayBold, color: R.color.black),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    viewModel.changeRentSelection();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: viewModel.rentSelection ? R.themeColor.primaryLight : R.themeColor.boxBg,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.5),
                                    child: TextBasic(
                                      text: 'Ekonomik Kiralık',
                                      fontSize: 18,
                                      color: viewModel.rentSelection ? R.themeColor.primary : R.themeColor.secondary,
                                      fontFamily: R.fonts.displayBold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    viewModel.changeRentSelection();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: !viewModel.rentSelection ? R.themeColor.primaryLight : R.themeColor.boxBg,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.5),
                                    child: TextBasic(
                                      text: 'Lüks Kiralık',
                                      fontSize: 18,
                                      color: !viewModel.rentSelection ? R.themeColor.primary : R.themeColor.secondary,
                                      fontFamily: R.fonts.displayBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //const SizedBox(height: 20),
                    //const WidgetPublicRentCarCard(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _vehicleFeatureSelection(BuildContext context, VmPublicHome viewModel) => SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 40)) / 5,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoFeatureSelection(icon: R.drawable.svg.iconEvaluateCar, description: 'Aracınızı Değerleyin'),
            ),
            const SizedBox(width: 10),
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 40)) / 5,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoFeatureSelection(icon: R.drawable.svg.iconColumns, description: 'Karşılaştırın'),
            ),
            const SizedBox(width: 10),
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 40)) / 5,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoFeatureSelection(icon: R.drawable.svg.iconSearch, description: 'Hasar Sorgulayın'),
            ),
            const SizedBox(width: 10),
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 40)) / 5,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoFeatureSelection(icon: R.drawable.svg.iconCursorRays, description: 'Benzin'),
            ),
            const SizedBox(width: 10),
            Container(
              width: (size(context).width - (size(context).width * 0.12 + 40)) / 5,
              decoration: BoxDecoration(color: R.themeColor.boxBg, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 40),
              child: WidgetInfoFeatureSelection(icon: R.drawable.svg.iconGlobe, description: 'Sıfır Dünyası'),
            ),
          ],
        ),
      );
}
