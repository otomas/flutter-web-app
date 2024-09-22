import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../base/base_view.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_search.dart';

@RoutePage()
class FragmentSearch extends StatefulWidget {
  const FragmentSearch({super.key});

  @override
  State<FragmentSearch> createState() => _FragmentSearchState();
}

class _FragmentSearchState extends WidgetBaseStatefull<FragmentSearch, VmFragmentSearch> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentSearch createViewModel(BuildContext context) => VmFragmentSearch(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentSearch viewModel) => const Center(child: TextBasic(text: 'search'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentSearch viewModel) => buildWidget(context, viewModel);
}
