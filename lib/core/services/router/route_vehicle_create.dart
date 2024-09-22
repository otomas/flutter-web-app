import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

final routeVehicleCreate = [
  RedirectRoute(path: '/create-vehicle/:vehicleId/*', redirectTo: '/create-vehicle/:vehicleId'),
  AutoRoute(
    path: '/create-vehicle/:vehicleId',
    page: RouteVehicleCreate.page,
    children: [
      RedirectRoute(path: '', redirectTo: '/customer-info'),
      AutoRoute(path: 'customer-info', page: FragmentVehicleCreateCustomerInfo.page),
      AutoRoute(path: 'info', page: FragmentVehicleCreateInfo.page),
      AutoRoute(path: 'expertise', page: FragmentVehicleCreateExpertise.page),
      AutoRoute(path: 'prices', page: FragmentVehicleCreatePrices.page),
    ],
  ),
];
