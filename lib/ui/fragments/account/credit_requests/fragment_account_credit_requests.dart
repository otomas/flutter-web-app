import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_account_credit_requests.dart';

@RoutePage()
class FragmentAccountCreditRequests extends StatefulWidget {
  const FragmentAccountCreditRequests({super.key});

  @override
  State<FragmentAccountCreditRequests> createState() => _FragmentAccountCreditRequestsState();
}

class _FragmentAccountCreditRequestsState extends WidgetBaseStatefull<FragmentAccountCreditRequests, VmFragmentAccountCreditRequests> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentAccountCreditRequests createViewModel(BuildContext context) => VmFragmentAccountCreditRequests(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentAccountCreditRequests viewModel) => const Center(child: TextBasic(text: 'credit requests'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentAccountCreditRequests viewModel) => buildWidget(context, viewModel);
}
