import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

import '../enums/enum_app.dart';
import '../services/router/router.gr.dart';
import 'general_data.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isAuthenticated = GeneralData.getInstance().getAuthState() == AuthState.authenticated;
    if (resolver.routeName.contains('RouteLogin')) {
      resolver.next();
      return;
    }
    if (isAuthenticated) {
      final lastRoute = GeneralData.getInstance().lastRoute;
      if (lastRoute != null) {
        GeneralData.getInstance().lastRoute = null;
        unawaited(resolver.redirect(lastRoute));
        return;
      }
      resolver.next();
    } else {
      if (resolver.routeName.contains('RouteForgotPassword') || resolver.routeName.contains('RouteRegister')) {
        resolver.next();
        return;
      }
      if (kIsWeb) {
        GeneralData.getInstance().lastRoute = resolver.route.children!.last.toPageRouteInfo();
      }
      await resolver.redirect(RouteLogin(), replace: true);
    }
  }
}
