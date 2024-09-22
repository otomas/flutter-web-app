import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/core/services/service_firebase.dart';
import '../../ui/base/base_bottom_sheet.dart';
import '../../ui/bs/bs_branch_selection.dart';
import '../constants/ui_brightness_style.dart';
import '../resources/_r.dart';
import '../utils/general_data.dart';
import 'router/router.dart';
import 'router/router.gr.dart';

class ServiceRoute extends ChangeNotifier {
  ServiceRoute(this.serviceFirebase) {
    navigatorKey = GlobalKey<NavigatorState>();
    rootRouter = RootRouter();
  }
  final ServiceFirebase serviceFirebase;
  final UIBrightnessStyle uiBrightnessStyle = UIBrightnessStyle();

  late GlobalKey<NavigatorState> navigatorKey;
  static late RootRouter rootRouter;
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> onBackPressed<T extends Object?>([T? result, ChangeNotifier? viewModel]) async {
    await rootRouter.maybePop(result);
  }

  void startVehicleCreateView(BuildContext context) {
    if (GeneralData.getInstance().getTokenData()?.autoGalleryBranchId == null) {
      unawaited(
        showBaseBottomSheet(
          context,
          BsBranchSelection(
            onSuccess: (branch) {
              startNewView(route: RouteVehicleCreate(branchId: branch.id));
            },
          ),
        ),
      );
    } else {
      unawaited(startNewView(route: RouteVehicleCreate()));
    }
  }

  Future<T?> startNewView<T>({required PageRouteInfo<dynamic> route, bool isReplace = false, bool clearStack = false}) async {
    T? value;
    if (isReplace && clearStack) {
      await rootRouter.replaceAll([route]);
    } else if (isReplace) {
      value = await rootRouter.replace<T>(route);
    } else {
      value = await rootRouter.push<T>(route);
    }
    return value;
  }

  Future<T?> startNewViewWithPath<T>({required String route}) async {
    final value = await rootRouter.pushNamed<T>(route);
    return value;
  }

  Future<void> showBaseBottomSheet(
    BuildContext context,
    Widget bottomSheet, {
    bool isDismissible = true,
    bool isActiveKeyboardPadding = true,
  }) async {
    if (kIsWeb) {
      unawaited(
        showDialog(
          context: context,
          builder: (context) => Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: (MediaQuery.of(context).size.aspectRatio > 1.5) ? (MediaQuery.of(context).size.height * 0.7) : (MediaQuery.of(context).size.height * 0.8),
                maxWidth: (MediaQuery.of(context).size.aspectRatio > 1.5) ? (MediaQuery.of(context).size.width * 0.5) : (MediaQuery.of(context).size.width * 0.8),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Material(
                  child: BottomSheetBase(isActiveKeyboardPadding: isActiveKeyboardPadding, child: bottomSheet),
                ),
              ),
            ),
          ),
        ),
      );
      return;
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: R.color.black.withOpacity(0.8),
      backgroundColor: R.color.transparent,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      builder: (context) => BottomSheetBase(isActiveKeyboardPadding: isActiveKeyboardPadding, child: bottomSheet),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
