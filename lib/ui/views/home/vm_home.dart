import 'package:flutter/material.dart';

import '../../../core/models/model_router_destinition.dart';
import '../../../core/resources/_r.dart';
import '../../../core/services/router/router.gr.dart';
import '../../../core/services/service_app.dart';
import '../../base/base_view_model.dart';

class VmHome extends ViewModelBase {
  VmHome(this.serviceApp) {
    init();
  }
  final ServiceApp serviceApp;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  final List<RouteDestination> fragments = [];

  @override
  void init() {
    fragments.addAll(
      [
        RouteDestination(route: const FragmentShowcase(), iconSvgPath: R.drawable.svg.iconShowcase, label: R.string.showcase, isCommon: true),
        RouteDestination(route: const FragmentEmpty(), iconSvgPath: R.drawable.svg.iconMarketPlace, label: R.string.marketplace, isCommon: true),
        RouteDestination(route: const FragmentSearch(), iconSvgPath: R.drawable.svg.iconSearch, label: R.string.search, isCommon: true),
        RouteDestination(route: const FragmentForMe(), iconSvgPath: R.drawable.svg.iconProfile, label: 'For Me', isCommon: true),
        RouteDestination(route: FragmentVehiclesMine(), iconSvgPath: R.drawable.svg.iconProfile, label: 'My Vehicles'),
        RouteDestination(route: FragmentVehiclesArchived(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Archived Vehicles'),
        RouteDestination(route: FragmentVehiclesPurchased(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Purchased Vehicles'),
        RouteDestination(route: FragmentVehicleConsignment(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Consignment Vehicles'),
        RouteDestination(route: FragmentVehicleDeleted(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Deleted Vehicles'),
        RouteDestination(route: FragmentVehicleInventory(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Vehicle Inventory'),
        RouteDestination(route: FragmentVehicleSold(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Sold Vehicles'),
        RouteDestination(route: const FragmentAccountBalanceTopUp(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Top Up Balance'),
        RouteDestination(route: const FragmentAccountBankAccounts(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Bank Accounts'),
        RouteDestination(route: const FragmentAccountInvoices(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Bills'),
        RouteDestination(route: const FragmentAccountBook(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Account Book'),
        RouteDestination(route: const FragmentAccountBranchPosDevices(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Branch POS Devices'),
        RouteDestination(route: const FragmentAccountCreditRequests(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Credit Requests'),
        RouteDestination(route: const FragmentAccountTurnover(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Endorsement'),
        RouteDestination(route: const FragmentAuthorization(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Authorization'),
        RouteDestination(route: FragmentBranches(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Branches'),
        RouteDestination(route: FragmentUsers(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Clients'),
        RouteDestination(route: const FragmentFavorites(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Favorites'),
        RouteDestination(route: const FragmentMessages(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Messages'),
        RouteDestination(route: const FragmentMyAccount(), iconSvgPath: R.drawable.svg.iconProfile, label: 'My Account'),
        RouteDestination(route: const FragmentNotifications(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Notifications'),
        RouteDestination(route: const FragmentQueriesDamageRecord(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Damage Record Queries'),
        RouteDestination(route: const FragmentQueriesKilometer(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Kilometer Queries'),
        RouteDestination(route: const FragmentQueriesPartChange(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Part Change Queries'),
        RouteDestination(route: const FragmentSettings(), iconSvgPath: R.drawable.svg.iconSettings, label: 'Settings'),
        RouteDestination(route: const FragmentSupportRequests(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Support Requests'),
        RouteDestination(route: FragmentUsers(), iconSvgPath: R.drawable.svg.iconProfile, label: 'Users'),
        RouteDestination(route: FragmentCustomer(), iconSvgPath: R.drawable.svg.iconCustomer, label: 'Customers'),
      ],
    );
  }
}
