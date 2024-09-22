import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

final routeVehicleDetail = [
  AutoRoute(
    path: '/vehicle/:vehicleId',
    page: RouteVehicleDetail.page,
    children: [
      AutoRoute(path: 'info', page: FragmentVehicleDetailInfo.page),
      AutoRoute(path: 'ad-info', page: FragmentVehicleDetailAdInfo.page),
      AutoRoute(path: 'info-card', page: FragmentVehicleDetailInfoCard.page),
      AutoRoute(path: 'query-damage', page: FragmentVehicleDetailQueryDamage.page),
      AutoRoute(path: 'query-part-change', page: FragmentVehicleDetailQueryPartChange.page),
      AutoRoute(path: 'query-kilometer', page: FragmentVehicleDetailQueryKilometer.page),
    ],
  ),
];
