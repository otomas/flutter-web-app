import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/resources/_r.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_web.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_vehicle_create.dart';

@RoutePage()
class ViewVehicleCreate extends WidgetBase<VmVehicleCreate> {
  const ViewVehicleCreate({
    super.key,
    super.isActiveLoadingIndicator = true,
    @PathParam('vehicleId') this.vehicleId,
    @QueryParam('branchId') this.branchId,
  });
  final int? vehicleId;
  final int? branchId;

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmVehicleCreate createViewModel(BuildContext context) => VmVehicleCreate(apiService(context), router(context), vehicleId, branchId);

  @override
  Widget buildWidgetForWeb(BuildContext context, VmVehicleCreate viewModel) => _getTabsRouter(
        context,
        viewModel,
        (fragment) => Scaffold(
          backgroundColor: R.themeColor.boxBg,
          body: WidgetWebBase(
            child: Row(
              children: [
                _getTabs(context, viewModel),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: R.themeColor.viewBg,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 24,
                          color: R.themeColor.viewText.withOpacity(0.05),
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: fragment,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  @override
  Widget buildWidget(BuildContext context, VmVehicleCreate viewModel) => _getTabsRouter(
        context,
        viewModel,
        (fragment) => Scaffold(
          body: Column(
            children: [
              _getTabs(context, viewModel),
              Expanded(child: fragment),
            ],
          ),
        ),
      );

  Widget _getTabsRouter(BuildContext context, VmVehicleCreate viewModel, Widget Function(Widget child) child) => viewModel.fragments.isEmpty ? Container() : AutoTabsRouter(
        routes: viewModel.fragments.map((e) => e.route).toList(),
        builder: (context, fragment) {
          viewModel.setTabsRouter(context.tabsRouter);
          return child(fragment);
        },
      );

  Widget _getTabs(BuildContext context, VmVehicleCreate viewModel) => Container(
        height: isWeb(context) ? double.infinity : null,
        width: isWeb(context) ? null : double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20, top: systemPadding(context).top + 12.0, bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(isWeb(context) ? 24 : 0),
            bottomRight: const Radius.circular(24),
            bottomLeft: Radius.circular(!isWeb(context) ? 24 : 0),
          ),
          color: R.themeColor.boxBg,
        ),
        child: isWeb(context)
            ? ScrollWithNoGlowWidget(
                padding: EdgeInsets.only(left: size(context).width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getTabItems(context, viewModel),
                ),
              )
            : ScrollWithNoGlowWidget(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _getTabItems(context, viewModel),
                ),
              ),
      );

  List<Widget> _getTabItems(BuildContext context, VmVehicleCreate viewModel) => List.generate(
        viewModel.fragments.length,
        (index) {
          final item = viewModel.fragments[index];
          return Container(
            margin: const EdgeInsets.only(right: 18, top: 20),
            child: Row(
              children: [
                Container(
                  height: 52,
                  width: 52,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: viewModel.tabsRouter.activeIndex > index
                        ? R.themeColor.success
                        : viewModel.tabsRouter.activeIndex == index
                            ? R.themeColor.primary
                            : R.themeColor.viewBg,
                    shape: BoxShape.circle,
                    border: viewModel.tabsRouter.activeIndex > index
                        ? null
                        : viewModel.tabsRouter.activeIndex == index
                            ? null
                            : Border.all(color: R.color.transparent),
                    boxShadow: [
                      BoxShadow(
                        color: R.themeColor.viewText.withOpacity(0.2), // Gölgenin rengi ve opaklığı
                        spreadRadius: .2, // Gölgenin yayılma alanı
                        blurRadius: 6, // Gölgenin bulanıklığı
                        offset: const Offset(0, 4), // X ve Y ekseninde gölgenin pozisyonu (yatay ve dikey kaydırma)
                      ),
                    ],
                  ),
                  child: Center(
                    child: viewModel.tabsRouter.activeIndex > index
                        ? Icon(Icons.check, color: R.color.white, size: 14)
                        : TextBasic(
                            text: (index + 1).toString(),
                            color: viewModel.tabsRouter.activeIndex == index ? R.color.white : R.color.gray,
                            fontFamily: R.fonts.displayBold,
                          ),
                  ),
                ),
                const SizedBox(height: 5),
                TextBasic(
                  text: item.label,
                  color: viewModel.tabsRouter.activeIndex > index
                      ? R.themeColor.success
                      : viewModel.tabsRouter.activeIndex == index
                          ? R.themeColor.primary
                          : R.color.gray,
                  fontFamily: viewModel.tabsRouter.activeIndex > index
                      ? R.fonts.displayBold
                      : viewModel.tabsRouter.activeIndex == index
                          ? R.fonts.displayBold
                          : R.fonts.displayRegular,
                  textAlign: TextAlign.left,
                  fontSize: 16,
                ),
              ],
            ),
          );
        },
      );
}
