import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/ui_brightness_style.dart';
import '../../../base/base_view.dart';
import 'vm_vehicle_doping.dart';

@RoutePage()
class ViewVehicleDoping extends WidgetBase<VmVehicleDoping> {
  const ViewVehicleDoping({
    @PathParam('vehicleId') required this.vehicleId,
    @QueryParam('branchId') this.branchId,
    super.key,
    super.isActiveLoadingIndicator = true,
  });
  final int vehicleId;
  final int? branchId;

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmVehicleDoping createViewModel(BuildContext context) => VmVehicleDoping(apiService(context), vehicleId, branchId);

  @override
  Widget buildWidgetForWeb(BuildContext context, VmVehicleDoping viewModel) => buildWidget(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmVehicleDoping viewModel) => Center(child: Text('doping $vehicleId'));
}
