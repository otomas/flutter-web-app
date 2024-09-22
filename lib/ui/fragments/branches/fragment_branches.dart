import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_branches.dart';

@RoutePage()
class FragmentBranches extends StatefulWidget {
  const FragmentBranches({super.key});

  @override
  State<FragmentBranches> createState() => _FragmentBranchesState();
}

class _FragmentBranchesState extends WidgetBaseStatefull<FragmentBranches, VmFragmentBranches> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentBranches createViewModel(BuildContext context) => VmFragmentBranches(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentBranches viewModel) => const Center(child: TextBasic(text: 'branches'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentBranches viewModel) => buildWidget(context, viewModel);
}
