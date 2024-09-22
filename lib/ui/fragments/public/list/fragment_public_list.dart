import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import 'vm_fragment_public_list.dart';

@RoutePage()
class FragmentPublicList extends StatefulWidget {
  const FragmentPublicList({
    super.key,
  });

  @override
  State<FragmentPublicList> createState() => _FragmentPublicListState();
}

class _FragmentPublicListState extends WidgetBaseStatefull<FragmentPublicList, VmFragmentPublicList> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentPublicList createViewModel(BuildContext context) => VmFragmentPublicList(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentPublicList viewModel) => const Center(child: Text('vehicle-detail-info-card'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentPublicList viewModel) => buildWidget(context, viewModel);
}
