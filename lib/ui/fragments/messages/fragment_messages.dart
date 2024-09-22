import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_messages.dart';

@RoutePage()
class FragmentMessages extends StatefulWidget {
  const FragmentMessages({super.key});

  @override
  State<FragmentMessages> createState() => _FragmentMessagesState();
}

class _FragmentMessagesState extends WidgetBaseStatefull<FragmentMessages, VmFragmentMessages> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentMessages createViewModel(BuildContext context) => VmFragmentMessages(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentMessages viewModel) => const Center(child: TextBasic(text: 'messages'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentMessages viewModel) => buildWidget(context, viewModel);
}
