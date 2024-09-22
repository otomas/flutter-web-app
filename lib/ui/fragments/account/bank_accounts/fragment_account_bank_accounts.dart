import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_account_bank_accounts.dart';

@RoutePage()
class FragmentAccountBankAccounts extends StatefulWidget {
  const FragmentAccountBankAccounts({super.key});

  @override
  State<FragmentAccountBankAccounts> createState() => _FragmentAccountBankAccountsState();
}

class _FragmentAccountBankAccountsState extends WidgetBaseStatefull<FragmentAccountBankAccounts, VmFragmentAccountBankAccounts> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentAccountBankAccounts createViewModel(BuildContext context) => VmFragmentAccountBankAccounts(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentAccountBankAccounts viewModel) => const Center(child: TextBasic(text: 'bank accounts'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentAccountBankAccounts viewModel) => buildWidget(context, viewModel);
}
