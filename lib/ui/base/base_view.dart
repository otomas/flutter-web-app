import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/core/resources/_r.dart';
import '../../core/constants/app_config.dart';
import '../../core/enums/enum_app.dart';
import '../../core/models/model_alert_dialog.dart';
import '../../core/services/router/router.gr.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_app.dart';
import '../../core/services/service_firebase.dart';
import '../../core/services/service_route.dart';
import '../../core/utils/alert_utils.dart';
import '../../core/utils/utilities.dart';
import '../widgets/activity_indicator.dart';
import 'base_view_model.dart';

abstract class WidgetBaseStatefull<Y extends StatefulWidget, T extends ViewModelBase> extends State<Y> with BaseView, AutomaticKeepAliveClientMixin<Y> {
  @override
  bool get wantKeepAlive => true;

  bool isActiveLoadingIndicator = true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    di<ServiceApp>(context, listen: true);
    return GestureDetector(
      onTap: () => router(context).hideKeyboard(context),
      child: systemBarBrightness() == null
          ? _provider()
          : AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemBarBrightness() ?? SystemUiOverlayStyle.dark,
              child: _provider(),
            ),
    );
  }

  Widget _provider() => ChangeNotifierProvider<T>(
        create: createViewModel,
        builder: (context, child) => Consumer<T>(
          builder: (context, viewModel, child) {
            initListener(context, viewModel);
            return !isActiveLoadingIndicator
                ? isWeb(context)
                    ? buildWidgetForWeb(context, viewModel)
                    : buildWidget(context, viewModel)
                : Stack(
                    children: [
                      if (isWeb(context)) buildWidgetForWeb(context, viewModel) else buildWidget(context, viewModel),
                      if (viewModel.activityState == ActivityState.isLoading)
                        Positioned(
                          left: 0,
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: const ActivityIndicator(),
                          ),
                        ),
                    ],
                  );
          },
        ),
      );

  Widget buildWidget(BuildContext context, T viewModel);
  Widget buildWidgetForWeb(BuildContext context, T viewModel);

  T createViewModel(BuildContext context);
  SystemUiOverlayStyle? systemBarBrightness();
}

abstract class WidgetBase<T extends ViewModelBase> extends StatelessWidget with BaseView {
  const WidgetBase({
    super.key,
    this.isActiveLoadingIndicator = true,
  });
  final bool isActiveLoadingIndicator;

  @override
  Widget build(BuildContext context) {
    di<ServiceApp>(context, listen: true);

    return GestureDetector(
      onTap: () => router(context).hideKeyboard(context),
      child: systemBarBrightness() == null
          ? _provider(context)
          : AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemBarBrightness() ?? SystemUiOverlayStyle.dark,
              child: _provider(context),
            ),
    );
  }

  Widget _provider(BuildContext context) => ChangeNotifierProvider<T>(
        create: createViewModel,
        builder: (context, child) => Consumer<T>(
          builder: (context, viewModel, child) {
            initListener(context, viewModel);
            return !isActiveLoadingIndicator
                ? isWeb(context)
                    ? buildWidgetForWeb(context, viewModel)
                    : buildWidget(context, viewModel)
                : Stack(
                    children: [
                      if (isWeb(context)) buildWidgetForWeb(context, viewModel) else buildWidget(context, viewModel),
                      if (viewModel.activityState == ActivityState.isLoading)
                        Positioned(
                          left: 0,
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: const ActivityIndicator(),
                          ),
                        ),
                    ],
                  );
          },
        ),
      );

  Widget buildWidget(BuildContext context, T viewModel);
  Widget buildWidgetForWeb(BuildContext context, T viewModel);

  T createViewModel(BuildContext context);
  SystemUiOverlayStyle? systemBarBrightness();
}

mixin BaseView {
  double fragmentWidth(BuildContext context) => !isWeb(context) ? size(context).width : size(context).width - ((max(size(context).width * 0.15, 200)) + (size(context).width * 0.06 * 2 - 20));
  bool isWeb(BuildContext context) => MediaQuery.of(context).size.aspectRatio > 1.5;
  Size size(BuildContext context) => MediaQuery.of(context).size;
  EdgeInsets systemPadding(BuildContext context) => MediaQuery.of(context).padding;
  EdgeInsets viewInsets(BuildContext context) => MediaQuery.of(context).viewInsets;
  bool keyboardVisibility(BuildContext context) => MediaQuery.of(context).viewInsets.bottom > 0;

  ServiceRoute router(context, [bool listen = false]) => Provider.of<ServiceRoute>(context, listen: listen);
  ServiceApi apiService(context, [bool listen = false]) => Provider.of<ServiceApi>(context, listen: listen);
  ServiceFirebase firebaseService(context, [bool listen = false]) => Provider.of<ServiceFirebase>(context, listen: listen);

  void requestFocus(BuildContext context, FocusNode focusNode) => FocusScope.of(context).requestFocus(focusNode);

  T di<T>(BuildContext context, {bool listen = false}) => Provider.of<T>(context, listen: listen);

  void initListener(BuildContext context, ViewModelBase viewModel) {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    if (!viewModel.errorObserver.hasListeners) {
      viewModel.errorObserver.addListener(
        (property) {
          if (property == errorPropertyMessageTag && viewModel.errorObserver.message.isNotEmpty) {
            if (context.mounted) {
              unawaited(showPlatformAlert(context, ModelAlertDialog(description: viewModel.errorObserver.message, dialogType: DialogTypes.error)));
            } else {
              showInSnackBar(viewModel.errorObserver.message);
            }
            viewModel.errorObserver.message = '';
          }
          if (property == errorPropertyActivityActionStateTag && viewModel.errorObserver.activityErrorActionState != ActivityErrorActionState.none) {
            if (viewModel.errorObserver.activityErrorActionState == ActivityErrorActionState.logout) {
              unawaited(
                showPlatformAlert(
                  context,
                  ModelAlertDialog(
                    title:'Çıkış Yap',
                    description: R.string.logoutConfirmation,
                    isActiveCancelButton: true,
                    dialogType: DialogTypes.confirmation,
                    onPressedButton: () => mLogout(context),
                  ),
                ),
              );
            } else if (viewModel.errorObserver.activityErrorActionState == ActivityErrorActionState.directLogout) {
              mLogout(context);
            }
            viewModel.errorObserver.activityErrorActionState = ActivityErrorActionState.none;
          }
        },
        [errorPropertyMessageTag, errorPropertyActivityActionStateTag],
      );
    }

    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    if (!viewModel.alertObserver.hasListeners) {
      viewModel.alertObserver.addListener(
        (property) {
          if (property == alertPropertyTag && viewModel.alertObserver.alert.description.isNotEmpty) {
            if (context.mounted) {
              unawaited(showPlatformAlert(context, viewModel.alertObserver.alert));
            } else {
              showInSnackBar(viewModel.alertObserver.alert.description);
            }
            viewModel.alertObserver.alert = null;
          }
        },
        [alertPropertyTag],
      );
    }
  }

  void mLogout(BuildContext context) {
    clearUserData(apiService(context));
    unawaited(router(context).startNewView(route: RouteLogin(), isReplace: true, clearStack: true));
  }
}
