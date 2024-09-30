import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/auth_guards.dart';
import 'route_home.dart';
import 'route_vehicle_create.dart';
import 'route_vehicle_detail.dart';
import 'router.gr.dart';

@AutoRouterConfig(
  generateForDir: ['lib/ui/views', 'lib/ui/fragments'],
  replaceInRouteName: 'View,Route',
)
class RootRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  late final List<AutoRouteGuard> guards = [AuthGuard()];

  @override
  final List<AutoRoute> routes = [
    // AUTH
    AutoRoute(path: '/splash', page: RouteSplash.page),
    AutoRoute(path: '/login', page: RouteLogin.page),
    AutoRoute(path: '/register', page: RouteRegister.page),
    AutoRoute(path: '/forgot-password', page: RouteForgotPassword.page),
    AutoRoute(path: '/public', page: RoutePublicHome.page),
    AutoRoute(path: '/public-detail', page: RoutePublicDetail.page),

    // HOME & FRAGMENTS
    ...routeHome,

    // VEHICLE CREATE
    ...routeVehicleCreate,

    // VEHICLE DETAIL
    ...routeVehicleDetail,

    // VEHICLE ADD DOPING
    AutoRoute(path: '/add-doping/:vehicleId', page: RouteVehicleDoping.page),

    // SHOWCASE
    AutoRoute(
      path: '/marketplace',
      page: RouteMarketPlace.page,
      children: [
        AutoRoute(path: 'filter', page: FragmentMarketPlace.page),
      ],
    ),

    // initial view is splash
    RedirectRoute(path: '*', redirectTo: kIsWeb ? '/login' : '/splash'),
  ];
}

class RooterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('didPush: ${route.isActive}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log('didPop: ${route.isActive} ${previousRoute!.isActive}');
  }
}
