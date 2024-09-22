import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/ui_brightness_style.dart';
import '../../base/base_view.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_showcase.dart';

@RoutePage()
class FragmentShowcase extends StatefulWidget {
  const FragmentShowcase({super.key});

  @override
  State<FragmentShowcase> createState() => _FragmentShowcaseState();
}

class _FragmentShowcaseState extends WidgetBaseStatefull<FragmentShowcase, VmFragmentShowcase> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentShowcase createViewModel(BuildContext context) => VmFragmentShowcase(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentShowcase viewModel) => const Center(child: TextBasic(text: 'showcase'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentShowcase viewModel) => buildWidget(context, viewModel);
}
