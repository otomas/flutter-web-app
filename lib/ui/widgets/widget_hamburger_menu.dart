import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/models/model_expandable_item.dart';
import '../../core/resources/_r.dart';
import '../../core/services/router/router.gr.dart';
import '../../core/utils/general_data.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widget_button.dart';
import 'widget_expandable_list.dart';
import 'widget_scroll.dart';
import 'widgets_text.dart';

class WidgetHamburgerMenu extends WidgetBase<VmWidgetHamburgerMenu> {
  const WidgetHamburgerMenu({
    required this.scaffoldKey,
    required this.tabsRouter,
    super.key,
    super.isActiveLoadingIndicator = false,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final TabsRouter tabsRouter;

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetHamburgerMenu createViewModel(BuildContext context) => VmWidgetHamburgerMenu();

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetHamburgerMenu viewModel) => Container(
        width: size(context).width * 0.15,
        constraints: const BoxConstraints(minWidth: 200),
        height: size(context).height,
        color: R.themeColor.viewBg,
        child: ScrollWithNoGlowWidget(child: _getMenuItems(context, viewModel)),
      );

  @override
  Widget buildWidget(BuildContext context, VmWidgetHamburgerMenu viewModel) => ScrollWithNoGlowWidget(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _getHeader(context, viewModel),
            const SizedBox(height: 20),
            _getMenuItems(context, viewModel),
          ],
        ),
      );

  Widget _getHeader(BuildContext context, VmWidgetHamburgerMenu viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              SvgPicture.asset(R.drawable.svg.logo, width: 100),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => scaffoldKey.currentState?.closeDrawer(),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: R.themeColor.primaryLight),
                  child: Icon(Icons.clear, color: R.themeColor.primary),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: R.themeColor.boxBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: R.color.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: R.color.black.withOpacity(0.05),
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: TextBasic(
                      text: GeneralData.getInstance().getTokenData()?.fullName[0] ?? '-',
                      color: R.themeColor.primary,
                      fontSize: 26,
                      fontFamily: R.fonts.displayBold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBasic(
                        text: GeneralData.getInstance().getTokenData()?.fullName ?? '-',
                        color: R.themeColor.secondary,
                        fontFamily: R.fonts.displayBold,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 5),
                      TextBasic(text: GeneralData.getInstance().getTokenData()?.company?.title ?? '-', color: R.themeColor.secondary, fontSize: 12),
                      const SizedBox(height: 5),
                      const ButtonPremium(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _getMenuItems(BuildContext context, VmWidgetHamburgerMenu viewModel) => Column(
        children: [
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconMarketPlace,
            title: R.string.marketplace,
            onPressedItem: () {
              unawaited(router(context).startNewView(route: RouteMarketPlace()));
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconForMe,
            title: R.string.forMe,
            isSelected: tabsRouter.currentPath.contains('for-me'),
            onPressedItem: () {
              tabsRouter.setActiveIndex(3);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconProfile,
            title: R.string.myAccount,
            isSelected: tabsRouter.currentPath.contains('my-account'),
            isPremium: true,
            onPressedItem: () {
              tabsRouter.setActiveIndex(23);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconAuthorization,
            title: R.string.authorization,
            isSelected: tabsRouter.currentPath.contains('authorization'),
            onPressedItem: () {
              tabsRouter.setActiveIndex(18);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconCars,
            title: R.string.vehicles,
            items: [
              ModelExpandableListItem(
                title: R.string.myVehicles,
                isSelected: tabsRouter.currentPath.contains('vehicles-mine'),
                onTap: () {
                  tabsRouter.setActiveIndex(4);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.vehiclesPurchased,
                isSelected: tabsRouter.currentPath.contains('vehicles-purchased'),
                onTap: () {
                  tabsRouter.setActiveIndex(6);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.vehiclesSold,
                isSelected: tabsRouter.currentPath.contains('vehicles-sold'),
                onTap: () {
                  tabsRouter.setActiveIndex(10);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.vehiclesForArchive,
                isSelected: tabsRouter.currentPath.contains('vehicles-archived'),
                onTap: () {
                  tabsRouter.setActiveIndex(5);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.inventory,
                isSelected: tabsRouter.currentPath.contains('vehicles-inventory'),
                onTap: () {
                  tabsRouter.setActiveIndex(9);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.consignmentVehicles,
                isSelected: tabsRouter.currentPath.contains('vehicles-consignment'),
                onTap: () {
                  tabsRouter.setActiveIndex(7);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.deletedVehicles,
                isSelected: tabsRouter.currentPath.contains('vehicles-deleted'),
                onTap: () {
                  tabsRouter.setActiveIndex(8);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
            ],
            onPressedItem: () {},
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconStar,
            title: R.string.myFavorites,
            isSelected: tabsRouter.currentPath.contains('favorites'),
            onPressedItem: () {
              tabsRouter.setActiveIndex(21);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconCustomer,
            title: R.string.customers,
            isSelected: tabsRouter.currentPath.contains('customers'),
            onPressedItem: () {
              tabsRouter.setActiveIndex(31);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconAccounting,
            title: R.string.accounting,
            items: [
              ModelExpandableListItem(
                title: R.string.accountBook,
                isSelected: tabsRouter.currentPath.contains('account-book'),
                onTap: () {
                  tabsRouter.setActiveIndex(14);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.turnover,
                isSelected: tabsRouter.currentPath.contains('account-turnover'),
                onTap: () {
                  tabsRouter.setActiveIndex(17);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.bankAccounts,
                isSelected: tabsRouter.currentPath.contains('account-bank-accounts'),
                onTap: () {
                  tabsRouter.setActiveIndex(12);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.branchPosDevices,
                isSelected: tabsRouter.currentPath.contains('account-branch-pos-devices'),
                onTap: () {
                  tabsRouter.setActiveIndex(15);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.invoices,
                isSelected: tabsRouter.currentPath.contains('account-invoices'),
                onTap: () {
                  tabsRouter.setActiveIndex(13);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.balanceTopUp,
                isSelected: tabsRouter.currentPath.contains('account-balance-top-up'),
                onTap: () {
                  tabsRouter.setActiveIndex(11);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
            ],
            onPressedItem: () {},
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconSearch,
            title: R.string.query,
            items: [
              ModelExpandableListItem(
                title: R.string.damageRecordInquiry,
                isSelected: tabsRouter.currentPath.contains('queries-damage-record'),
                onTap: () {
                  tabsRouter.setActiveIndex(25);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.partChangeQueries,
                isSelected: tabsRouter.currentPath.contains('queries-part-change'),
                onTap: () {
                  tabsRouter.setActiveIndex(27);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ModelExpandableListItem(
                title: R.string.kilometerQueries,
                isSelected: tabsRouter.currentPath.contains('queries-kilometer'),
                onTap: () {
                  tabsRouter.setActiveIndex(26);
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
            ],
            onPressedItem: () {},
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconBranch,
            title: R.string.branches,
            isSelected: tabsRouter.currentPath.contains('branches'),
            onPressedItem: () {
              tabsRouter.setActiveIndex(19);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconChat,
            title: R.string.messages,
            isSelected: tabsRouter.currentPath.contains('messages'),
            onPressedItem: () {
              tabsRouter.setActiveIndex(22);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconUser,
            title: R.string.users,
            isSelected: tabsRouter.currentPath.contains('users'),
            onPressedItem: () {
              tabsRouter.setActiveIndex(30);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconNotification,
            title: R.string.notifications,
            isSelected: tabsRouter.currentPath.contains('notifications'),
            onPressedItem: () {
              tabsRouter.setActiveIndex(24);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          // WidgetExpandableListView(
          //   key: UniqueKey(),
          //   icon: R.drawable.svg.iconCall,
          //   title: R.string.supportRequests,
          //   isSelected: tabsRouter.currentPath.contains('support-requests'),
          //   onPressedItem: () {
          //     tabsRouter.setActiveIndex(29);
          //     scaffoldKey.currentState?.closeDrawer();
          //   },
          // ),
          WidgetExpandableListView(
            key: UniqueKey(),
            icon: R.drawable.svg.iconSettings,
            title: R.string.settings,
            isSelected: tabsRouter.currentPath.contains('settings'),
            onPressedItem: () {
              tabsRouter.setActiveIndex(28);
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
        ],
      );
}

class VmWidgetHamburgerMenu extends ViewModelBase {
  VmWidgetHamburgerMenu() {
    init();
  }

  @override
  void init() {}
}
