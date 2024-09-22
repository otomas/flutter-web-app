import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_account_balance_top_up.dart';

@RoutePage()
class FragmentAccountBalanceTopUp extends StatefulWidget {
  const FragmentAccountBalanceTopUp({super.key});

  @override
  State<FragmentAccountBalanceTopUp> createState() => _FragmentAccountBalanceTopUpState();
}

class _FragmentAccountBalanceTopUpState extends WidgetBaseStatefull<FragmentAccountBalanceTopUp, VmFragmentAccountBalanceTopUp> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentAccountBalanceTopUp createViewModel(BuildContext context) => VmFragmentAccountBalanceTopUp(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentAccountBalanceTopUp viewModel) => const Center(child: TextBasic(text: 'balance  top up'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentAccountBalanceTopUp viewModel) => buildWidget(context, viewModel);
}
