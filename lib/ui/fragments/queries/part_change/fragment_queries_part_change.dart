import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_queries_part_change.dart';

@RoutePage()
class FragmentQueriesPartChange extends StatefulWidget {
  const FragmentQueriesPartChange({super.key});

  @override
  State<FragmentQueriesPartChange> createState() => _FragmentQueriesPartChangeState();
}

class _FragmentQueriesPartChangeState extends WidgetBaseStatefull<FragmentQueriesPartChange, VmFragmentQueriesPartChange> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentQueriesPartChange createViewModel(BuildContext context) => VmFragmentQueriesPartChange(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentQueriesPartChange viewModel) => const Center(child: TextBasic(text: 'part change queries'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentQueriesPartChange viewModel) => buildWidget(context, viewModel);
}
