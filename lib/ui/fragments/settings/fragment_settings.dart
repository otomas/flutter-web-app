import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/resources/_r.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widget_reset_password.dart';
import '../../widgets/widget_settings_switch.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_settings.dart';

@RoutePage()
class FragmentSettings extends StatefulWidget {
  const FragmentSettings({super.key});

  @override
  State<FragmentSettings> createState() => _FragmentSettingsState();
}

class _FragmentSettingsState extends WidgetBaseStatefull<FragmentSettings, VmFragmentSettings> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentSettings createViewModel(BuildContext context) => VmFragmentSettings(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentSettings viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: TextBasic(
              text: R.string.notificationSettings,
              fontSize: 18,
              color: R.themeColor.secondary,
              fontFamily: R.fonts.displayBold,
            ),
          ),
          const SizedBox(height: 10),
          _notificationSettings(),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(right: 15, left: 15),
            child: TextBasic(
              text: R.string.passwordAndSecurity,
              fontSize: 18,
              color: R.themeColor.secondary,
              fontFamily: R.fonts.displayBold,
            ),
          ),
          WidgetResetPassoword(
            title: R.string.changePassword,
            subTitle: R.string.passwordValidationRule,
          ),
          _switchSettings(),
        ],
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentSettings viewModel) => buildWidget(context, viewModel);

  Widget _notificationSettings() => Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            WidgetSettingsSwitch(
              title: R.string.desktopNotification,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            WidgetSettingsSwitch(
              title: R.string.smsNotification,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            WidgetSettingsSwitch(
              title: R.string.mailNotification,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            WidgetSettingsSwitch(
              title: R.string.smsAuth,
              subtitle: R.string.smsCodeAuth,
              onPressed: () {},
            ),
          ],
        ),
      );

  Widget _switchSettings() => Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetSettingsSwitch(
              title: R.string.securityQuestion,
              subtitle: R.string.takeSmsCode,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            WidgetSettingsSwitch(
              title: R.string.twoDVerification,
              subtitle: R.string.blockUnAuthLogin,
              onPressed: () {},
            ),
          ],
        ),
      );
}
