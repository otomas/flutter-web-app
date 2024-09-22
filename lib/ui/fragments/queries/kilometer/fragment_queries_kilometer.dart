import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_queries_kilometer.dart';

@RoutePage()
class FragmentQueriesKilometer extends StatefulWidget {
  const FragmentQueriesKilometer({super.key});

  @override
  State<FragmentQueriesKilometer> createState() => _FragmentQueriesKilometerState();
}

class _FragmentQueriesKilometerState extends WidgetBaseStatefull<FragmentQueriesKilometer, VmFragmentQueriesKilometer> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentQueriesKilometer createViewModel(BuildContext context) => VmFragmentQueriesKilometer(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentQueriesKilometer viewModel) => const Center(child: TextBasic(text: 'kilometer queries'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentQueriesKilometer viewModel) => buildWidget(context, viewModel);
}
