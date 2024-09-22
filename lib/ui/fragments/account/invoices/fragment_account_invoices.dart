import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_account_invoices.dart';

@RoutePage()
class FragmentAccountInvoices extends StatefulWidget {
  const FragmentAccountInvoices({super.key});

  @override
  State<FragmentAccountInvoices> createState() => _FragmentAccountInvoicesState();
}

class _FragmentAccountInvoicesState extends WidgetBaseStatefull<FragmentAccountInvoices, VmFragmentAccountInvoices> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentAccountInvoices createViewModel(BuildContext context) => VmFragmentAccountInvoices(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentAccountInvoices viewModel) => const Center(child: TextBasic(text: 'Invoices'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentAccountInvoices viewModel) => buildWidget(context, viewModel);
}
