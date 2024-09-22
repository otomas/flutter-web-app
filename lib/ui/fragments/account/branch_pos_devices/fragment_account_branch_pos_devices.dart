import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_account_branch_pos_devices.dart';

@RoutePage()
class FragmentAccountBranchPosDevices extends StatefulWidget {
  const FragmentAccountBranchPosDevices({super.key});

  @override
  State<FragmentAccountBranchPosDevices> createState() => _FragmentAccountBranchPosDevicesState();
}

class _FragmentAccountBranchPosDevicesState extends WidgetBaseStatefull<FragmentAccountBranchPosDevices, VmFragmentAccountBranchPosDevices> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentAccountBranchPosDevices createViewModel(BuildContext context) => VmFragmentAccountBranchPosDevices(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentAccountBranchPosDevices viewModel) => const Center(child: TextBasic(text: 'branch pos devices'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentAccountBranchPosDevices viewModel) => buildWidget(context, viewModel);
}
