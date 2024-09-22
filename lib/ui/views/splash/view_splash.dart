import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/models/model_alert_dialog.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/services/service_device_info.dart';
import '../../../../core/utils/alert_utils.dart';
import '../../../../core/utils/utilities.dart';
import '../../../../ui/base/base_view.dart';
import '../../../core/enums/enum_app.dart';
import '../../../core/services/router/router.gr.dart';
import 'vm_splash.dart';

@RoutePage()
class ViewSplash extends StatefulWidget {
  const ViewSplash({super.key});

  @override
  State<ViewSplash> createState() => _SplashState();
}

class _SplashState extends WidgetBaseStatefull<ViewSplash, VmSplash> {
  late VmSplash viewModel;
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmSplash createViewModel(BuildContext context) {
    di<ServiceDeviceInfo>(context);
    return viewModel = VmSplash(apiService(context), firebaseService(context), di<ServiceDeviceInfo>(context));
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      unawaited(router(context).startNewView(route: RouteLogin(), clearStack: true, isReplace: true));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // ignore: use_build_context_synchronously
        Future.delayed(const Duration(seconds: 3), () => unawaited(finishAnimation(context, viewModel)));
      });
    }
  }

  @override
  Widget buildWidget(BuildContext context, VmSplash viewModel) => Scaffold(body: _getBody(context, viewModel));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmSplash viewModel) => buildWidget(context, viewModel);

  Widget _getBody(BuildContext context, VmSplash viewModel) => _getLogo(context, viewModel);

  Widget _getLogo(BuildContext context, VmSplash viewModel) => kIsWeb
      ? Container()
      : Center(
          child: FadeInLeft(
            delay: const Duration(milliseconds: 2000),
            child: const Text('otomas'),
          ),
        );

  Future<void> finishAnimation(BuildContext context, VmSplash viewModel) async {
    final r = router(context);
    if (!kIsWeb) {
      final serviceFirebase = firebaseService(context);
      final serviceDeviceInfo = di<ServiceDeviceInfo>(context);
      await viewModel.checkDeviceRegister();

      final isActiveApp = await serviceFirebase.getIsActiveApp();
      if (!isActiveApp) {
        if (context.mounted) {
          await showPlatformAlert(
            context,
            ModelAlertDialog(
              dialogType: DialogTypes.error,
              description: R.string.appUnavailable,
              isDismissible: false,
              onPressedButton: () {
                exit(0);
              },
            ),
          );
        }
        return;
      }

      final version = await serviceFirebase.getVersionCode();
      final isUpdateRequired = await serviceFirebase.getIsUpdateRequired();
      if (context.mounted) {
        if (serviceDeviceInfo.buildNumber < version) {
          if (isUpdateRequired) {
            await showPlatformAlert(
              context,
              ModelAlertDialog(
                description: R.string.pleaseUpdateApp,
                dialogType: DialogTypes.warning,
                isDismissible: false,
                onPressedButton: () {
                  openStore(serviceDeviceInfo.appStoreId, serviceDeviceInfo.playStoreId);
                  exit(0);
                },
              ),
            );
            return;
          } else {
            showToast(R.string.versionCheckMessage((version - serviceDeviceInfo.buildNumber).toString()));
          }
        }
      }
      unawaited(r.startNewView(route: RouteLogin(), isReplace: true, clearStack: true));
    }
  }
}
