import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/enums/enum_app.dart';
import '../../core/models/model_public_vehicle_bar.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widget_image.dart';
import 'widgets_text.dart';

class WidgetPublicVehicleInfoBar extends WidgetBase<VmWidgetPublicVehicleInfoBar> {
  const WidgetPublicVehicleInfoBar({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetPublicVehicleInfoBar createViewModel(BuildContext context) => VmWidgetPublicVehicleInfoBar(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmWidgetPublicVehicleInfoBar viewModel) => Container();

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetPublicVehicleInfoBar viewModel) => viewModel.isLoading()
      ? const SizedBox(width: double.infinity, height: 100)
      : Container(
          width: size(context).width - (size(context).width * 0.12),
          decoration: BoxDecoration(
            color: R.color.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: R.themeColor.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(viewModel.data?.length ?? 0, (index) => IntrinsicWidth(child: _getCard(context, viewModel, index))),
          ),
        );

  Widget _getCard(BuildContext context, VmWidgetPublicVehicleInfoBar viewModel, int index) => Row(
    children: [
      Container(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 15),
        child: Column(
          children: [
            NetworkImageWithPlaceholder(height: 30, width: 30, imageUrl: viewModel.data?[index].icon ?? ''),
            const SizedBox(height: 5),
            TextBasic(text: viewModel.data?[index].typeName ?? '', fontSize: 12, color: R.themeColor.secondary, fontFamily: R.fonts.displayMedium),
            const SizedBox(height: 5),
            TextBasic(text: viewModel.data?[index].count.toString() ?? '', fontSize: 14, color: R.themeColor.primary),
          ],
        ),
      ),
      if (index != (viewModel.data?.length ?? 0) - 1)
        SizedBox(width: 1, height: 70, child: DecoratedBox(decoration: BoxDecoration(color: R.themeColor.border))),
    ],
  );
}

class VmWidgetPublicVehicleInfoBar extends ViewModelBase {
  VmWidgetPublicVehicleInfoBar(this.serviceApi) {
    init();
  }

  final ServiceApi serviceApi;
  List<ModelPublicVehicleBar>? data = [];

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getPublicVehicleBar().then(
      (response) {
        if (response.data != null) {
          data = response.data ?? [];
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }
}
