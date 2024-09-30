import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ServiceApp extends ChangeNotifier {
  final List<OverlayPortalController> dropdownTooltipControllers = [];

  late TabsRouter tabsRouter;
  // ignore: avoid_setters_without_getters
  set setTabsRouter(TabsRouter r) => tabsRouter = r;

  void notify() => notifyListeners();

  void closeDropdowns() {
    for (final controller in dropdownTooltipControllers) {
      controller.hide();
    }
  }
}
