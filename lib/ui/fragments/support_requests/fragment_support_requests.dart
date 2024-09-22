import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_support_requests.dart';

@RoutePage()
class FragmentSupportRequests extends StatefulWidget {
  const FragmentSupportRequests({super.key});

  @override
  State<FragmentSupportRequests> createState() => _FragmentSupportRequestsState();
}

class _FragmentSupportRequestsState extends WidgetBaseStatefull<FragmentSupportRequests, VmFragmentSupportRequests> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentSupportRequests createViewModel(BuildContext context) => VmFragmentSupportRequests(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentSupportRequests viewModel) => const Center(child: TextBasic(text: 'support requests'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentSupportRequests viewModel) => buildWidget(context, viewModel);
}
