import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_account_turnover.dart';

@RoutePage()
class FragmentAccountTurnover extends StatefulWidget {
  const FragmentAccountTurnover({super.key});

  @override
  State<FragmentAccountTurnover> createState() => _FragmentAccountTurnoverState();
}

class _FragmentAccountTurnoverState extends WidgetBaseStatefull<FragmentAccountTurnover, VmFragmentAccountTurnover> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentAccountTurnover createViewModel(BuildContext context) => VmFragmentAccountTurnover(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentAccountTurnover viewModel) => const Center(child: TextBasic(text: 'turnover'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentAccountTurnover viewModel) => buildWidget(context, viewModel);
}
