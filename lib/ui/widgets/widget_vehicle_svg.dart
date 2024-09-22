import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ucg_interactable_svg/interactable_svg/src/widgets/interactable_svg.dart';
import '../../core/extensions/extension_iterable.dart';
import '../../core/models/response/model_response_vehicle_color_flaw_groups.dart';
import '../../core/models/response/model_response_vehicle_report_checklist.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/utils/vehicle_svg.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widgets_text.dart';

class WidgetVehicleSVG extends WidgetBase<VmWidgetVehicleSVG> {
  const WidgetVehicleSVG({
    required this.vehicleColorFlawGroups,
    required this.selectedItems,
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  final List<ModelVehicleColorFlawGroup> vehicleColorFlawGroups;
  final Map<ModelVehicleReportChecklist, ModelVehicleColorFlawGroup> selectedItems;

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetVehicleSVG createViewModel(BuildContext context) => VmWidgetVehicleSVG(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetVehicleSVG viewModel) => buildWidget(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetVehicleSVG viewModel) => IntrinsicWidth(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isWeb(context) ? fragmentWidth(context) * 0.05 : size(context).width * 0.05),
              child: UcgInteractableSvg(
                key: const ValueKey(1),
                svgAddress: vehicleSvg,
                isActivePadding: !isWeb(context),
                unSelectableColor: (partId, color) {
                  final item = selectedItems.entries.firstWhereOrNull((e) => e.key.id == partId);
                  if (item != null) {
                    return Color(int.tryParse('0xFF${item.value.color}')!);
                  }
                  return null;
                },
                onChanged: (region) {
                  return;
                },
              ),
            ),
            const SizedBox(height: 20),
            WidgetExpertiseLabel(vehicleColorFlawGroups: vehicleColorFlawGroups, selectedItems: selectedItems),
          ],
        ),
      );
}

class VmWidgetVehicleSVG extends ViewModelBase {
  VmWidgetVehicleSVG(this.serviceApi) {
    init();
  }

  final ServiceApi serviceApi;

  @override
  void init() {}
}

class WidgetExpertiseLabel extends StatelessWidget {
  const WidgetExpertiseLabel({
    required this.vehicleColorFlawGroups,
    required this.selectedItems,
    super.key,
  });

  final List<ModelVehicleColorFlawGroup> vehicleColorFlawGroups;
  final Map<ModelVehicleReportChecklist, ModelVehicleColorFlawGroup> selectedItems;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            vehicleColorFlawGroups.length,
            (index) {
              final item = vehicleColorFlawGroups[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: index.isEven ? R.themeColor.boxBg : R.color.transparent,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(int.tryParse('0xFF${item.color}')!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: TextBasic(text: item.name ?? '', color: R.themeColor.secondaryHover, fontSize: 14)),
                    TextBasic(text: selectedItems.entries.where((e) => e.value.id == item.id).toList().length.toString()),
                  ],
                ),
              );
            },
          ),
        ],
      );
}
