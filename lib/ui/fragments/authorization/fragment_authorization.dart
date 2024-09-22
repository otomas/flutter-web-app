import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_authorization.dart';

@RoutePage()
class FragmentAuthorization extends StatefulWidget {
  const FragmentAuthorization({super.key});

  @override
  State<FragmentAuthorization> createState() => _FragmentAuthorizationState();
}

class _FragmentAuthorizationState extends WidgetBaseStatefull<FragmentAuthorization, VmFragmentAuthorization> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentAuthorization createViewModel(BuildContext context) => VmFragmentAuthorization(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentAuthorization viewModel) => const Center(child: TextBasic(text: 'authorization'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentAuthorization viewModel) => buildWidget(context, viewModel);
}
