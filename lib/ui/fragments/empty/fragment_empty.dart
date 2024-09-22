import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../base/base_view.dart';
import 'vm_fragment_empty.dart';

@RoutePage()
class FragmentEmpty extends StatefulWidget {
  const FragmentEmpty({super.key});

  @override
  State<FragmentEmpty> createState() => _FragmentEmptyState();
}

class _FragmentEmptyState extends WidgetBaseStatefull<FragmentEmpty, VmFragmentEmpty> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentEmpty createViewModel(BuildContext context) => VmFragmentEmpty(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentEmpty viewModel) => const SizedBox.shrink();

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentEmpty viewModel) => buildWidget(context, viewModel);
}
