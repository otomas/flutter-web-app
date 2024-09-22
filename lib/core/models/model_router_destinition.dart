import 'package:auto_route/auto_route.dart';

class RouteDestination {
  const RouteDestination({
    required this.route,
    required this.iconSvgPath,
    required this.label,
    this.isCommon = false,
  });
  final PageRouteInfo route;
  final String iconSvgPath;
  final String label;
  final bool isCommon;
}
