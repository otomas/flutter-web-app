import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_notifications.dart';

@RoutePage()
class FragmentNotifications extends StatefulWidget {
  const FragmentNotifications({super.key});

  @override
  State<FragmentNotifications> createState() => _FragmentNotificationsState();
}

class _FragmentNotificationsState extends WidgetBaseStatefull<FragmentNotifications, VmFragmentNotifications> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentNotifications createViewModel(BuildContext context) => VmFragmentNotifications(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentNotifications viewModel) => const Center(child: TextBasic(text: 'notifications'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentNotifications viewModel) => buildWidget(context, viewModel);
}
