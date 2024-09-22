import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_queries_damage_record.dart';

@RoutePage()
class FragmentQueriesDamageRecord extends StatefulWidget {
  const FragmentQueriesDamageRecord({super.key});

  @override
  State<FragmentQueriesDamageRecord> createState() => _FragmentQueriesDamageRecordState();
}

class _FragmentQueriesDamageRecordState extends WidgetBaseStatefull<FragmentQueriesDamageRecord, VmFragmentQueriesDamageRecord> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentQueriesDamageRecord createViewModel(BuildContext context) => VmFragmentQueriesDamageRecord(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentQueriesDamageRecord viewModel) => const Center(child: TextBasic(text: 'damage record queries'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentQueriesDamageRecord viewModel) => buildWidget(context, viewModel);
}
