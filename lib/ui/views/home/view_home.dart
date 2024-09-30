import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/resources/_r.dart';
import '../../../core/services/service_app.dart';
import '../../../core/utils/general_data.dart';
import '../../../ui/views/home/vm_home.dart';
import '../../base/base_view.dart';
import '../../widgets/widget_button.dart';
import '../../widgets/widget_hamburger_menu.dart';
import '../../widgets/widget_web.dart';
import '../../widgets/widgets_text.dart';

@RoutePage()
class ViewHome extends WidgetBase<VmHome> {
  const ViewHome({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmHome createViewModel(BuildContext context) => VmHome(di<ServiceApp>(context));

  @override
  Widget buildWidget(BuildContext context, VmHome viewModel) => _getTabsRouter(
        context,
        viewModel,
        (fragment) => Scaffold(
          key: viewModel.scaffoldkey,
          appBar: _getAppBar(context, viewModel),
          drawer: Container(
            color: R.themeColor.viewBg,
            width: size(context).width * 0.7,
            height: double.infinity,
            child: WidgetHamburgerMenu(
              scaffoldKey: viewModel.scaffoldkey,
              tabsRouter: viewModel.serviceApp.tabsRouter,
            ),
          ),
          body: fragment,
          bottomNavigationBar: viewModel.serviceApp.tabsRouter.activeIndex >= 4 ? null : _getBottomNavigationBar(context, viewModel),
          floatingActionButton: (viewModel.serviceApp.tabsRouter.activeIndex <= 10 && viewModel.serviceApp.tabsRouter.activeIndex > 16) ? FloatingActionButton(
            heroTag: DateTime.now().toIso8601String(),
            onPressed: () {
              router(context).startVehicleCreateView(context);
            },
            child: const Icon(Icons.add, size: 36),
          ) : null,
        ),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmHome viewModel) => _getTabsRouter(
        context,
        viewModel,
        (fragment) => Scaffold(
          body: WidgetWebBase(
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    left: (size(context).width * 0.06 - 20).abs(),
                    right: 50,
                    top: 20,
                  ),
                  child: WidgetHamburgerMenu(
                    scaffoldKey: viewModel.scaffoldkey,
                    tabsRouter: viewModel.serviceApp.tabsRouter,
                  ),
                ),
                Expanded(child: fragment),
                SizedBox(width: size(context).width * 0.06 - 20),
              ],
            ),
          ),
        ),
      );

  Widget _getTabsRouter(BuildContext context, VmHome viewModel, Widget Function(Widget child) child) => AutoTabsRouter(
        routes: viewModel.fragments.map((e) => e.route).toList(),
        builder: (context, fragment) {
          viewModel.serviceApp.setTabsRouter = context.tabsRouter;
          return child(fragment);
        },
      );

  Widget _getBottomNavigationBar(BuildContext context, VmHome viewModel) => BottomNavigationBar(
        elevation: 0,
        backgroundColor: R.color.transparent,
        currentIndex: viewModel.serviceApp.tabsRouter.activeIndex,
        onTap: viewModel.serviceApp.tabsRouter.setActiveIndex,
        selectedLabelStyle: TextStyle(fontSize: 12, fontFamily: R.fonts.displayBold, color: R.themeColor.primary),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: R.fonts.displayRegular, color: R.themeColor.smoke),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: R.themeColor.primary,
        unselectedItemColor: R.themeColor.smoke,
        items: List.generate(
          viewModel.fragments.where((e) => e.isCommon).map((e) => e.route).toList().length,
          (index) {
            final item = viewModel.fragments.where((e) => e.isCommon).toList()[index];
            return _getBottomNavigationBarItem(item.label, item.iconSvgPath);
          },
        ),
      );

  BottomNavigationBarItem _getBottomNavigationBarItem(String title, String iconPath) => BottomNavigationBarItem(
        icon: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            R.themeColor.secondary,
            BlendMode.srcIn,
          ),
          height: 24,
          width: 24,
        ),
        activeIcon: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            R.themeColor.primary,
            BlendMode.srcIn,
          ),
          height: 24,
          width: 24,
        ),
        label: title,
      );

  AppBar _getAppBar(BuildContext context, VmHome viewModel) => AppBar(
        centerTitle: false,
        backgroundColor: R.color.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            if (viewModel.serviceApp.tabsRouter.activeIndex < 4)
              GestureDetector(
                onTap: () {
                  viewModel.scaffoldkey.currentState?.openDrawer();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: R.themeColor.info),
                  child: Icon(Icons.menu, color: R.color.white),
                ),
              )
            else
              AppbarBackButton(
                onPressed: () => viewModel.serviceApp.tabsRouter.back(),
              ),
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
