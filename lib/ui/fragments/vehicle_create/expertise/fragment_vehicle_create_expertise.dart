import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/extensions/extension_iterable.dart';
import '../../../../core/models/request/model_request_vehicle.dart';
import '../../../../core/resources/_r.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_vehicle_create_fragment_base.dart';
import '../../../widgets/widget_vehicle_svg.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_vehicle_create_expertise.dart';

@RoutePage()
class FragmentVehicleCreateExpertise extends StatefulWidget {
  const FragmentVehicleCreateExpertise({
    required this.params,
    required this.onPressedPreviousButton,
    required this.onPressedNextButton,
    super.key,
  });

  final ModelRequestVehicleParams params;
  final Function() onPressedPreviousButton;
  final Function(ModelRequestVehicleParams newParams) onPressedNextButton;

  @override
  State<FragmentVehicleCreateExpertise> createState() => _FragmentVehicleCreateExpertiseState();
}

class _FragmentVehicleCreateExpertiseState extends WidgetBaseStatefull<FragmentVehicleCreateExpertise, VmFragmentVehicleCreateExpertise> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentVehicleCreateExpertise createViewModel(BuildContext context) => VmFragmentVehicleCreateExpertise(apiService(context), widget.params);

  @override
  Widget buildWidget(BuildContext context, VmFragmentVehicleCreateExpertise viewModel) {
    final fields = _getForm(context, viewModel);
    return _getBase(
      context,
      viewModel,
      ScrollWithNoGlowWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              fields.length,
              (index) => Column(
                children: [
                  ...List.generate(
                    fields[index].length,
                    (i) {
                      final item = fields[index][i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: item,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Divider(color: R.themeColor.border),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentVehicleCreateExpertise viewModel) {
    final fields = _getForm(context, viewModel);
    return _getBase(
      context,
      viewModel,
      ScrollWithNoGlowWidget(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                fields.length,
                (index) => Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: List.generate(
                          fields[index].length,
                          (i) {
                            final item = Expanded(flex: i == 0 ? 0 : 1, child: fields[index][i]);
                            return item;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(color: R.themeColor.border),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBase(BuildContext context, VmFragmentVehicleCreateExpertise viewModel, Widget child) => WidgetVehicleCreateFragmentBase(
        nextButtonText: 'Sonraki Adım',
        onPressedNextButton: () {
          if (viewModel.checkFields()) {
            widget.onPressedNextButton(viewModel.params);
          }
        },
        onPressedPreviousButton: widget.onPressedPreviousButton,
        previousButtonText: 'Önceki Adım',
        stepTitle: '3. Adım',
        title: 'Araç Ekspertiz Bilgileri',
        child: child,
      );

  List<List<Widget>> _getForm(BuildContext context, VmFragmentVehicleCreateExpertise viewModel) => [
        [
          WidgetVehicleSVG(
            key: UniqueKey(),
            selectedItems: viewModel.params.selectedExpertiseItems,
            vehicleColorFlawGroups: viewModel.vehicleColorFlawGroups,
          ),
          _getReportChecklistBox(context, viewModel),
        ],
      ];

  Widget _getReportChecklistBox(BuildContext context, VmFragmentVehicleCreateExpertise viewModel) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(child: SizedBox()),
                ...List.generate(
                  viewModel.vehicleColorFlawGroups.length,
                  (index) {
                    final item = viewModel.vehicleColorFlawGroups[index];
                    return SizedBox(
                      width: 100,
                      child: TextBasic(
                        text: item.name ?? '',
                        color: R.themeColor.secondaryHover,
                        fontFamily: R.fonts.displayBold,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ],
            ),
            ...List.generate(
              viewModel.reportChecklist.length,
              (index) {
                final item = viewModel.reportChecklist[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: index.isEven ? R.themeColor.boxBg : R.color.transparent,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextBasic(
                          text: item.name ?? '',
                          color: R.themeColor.secondaryHover,
                          fontFamily: R.fonts.displayBold,
                          fontSize: 14,
                        ),
                      ),
                      ...List.generate(
                        viewModel.vehicleColorFlawGroups.length,
                        (index) {
                          final group = viewModel.vehicleColorFlawGroups[index];
                          return GestureDetector(
                            onTap: () {
                              viewModel.updateSelectedList(item, group);
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              child: Center(
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: R.themeColor.border),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: viewModel.params.selectedExpertiseItems.entries.firstWhereOrNull((e) => e.key.id == item.id && e.value.id == group.id) != null ? R.themeColor.primary : R.color.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
}
