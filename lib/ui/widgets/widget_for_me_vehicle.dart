import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/enums/enum_app.dart';
import '../../core/models/response/model_response_vehicle_count_detail.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_app.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widgets_text.dart';

class WidgetForMeVehicle extends WidgetBase<VmWidgetForMeVehicle> {
  const WidgetForMeVehicle({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetForMeVehicle createViewModel(BuildContext context) => VmWidgetForMeVehicle(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetForMeVehicle viewModel) => buildWidget(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetForMeVehicle viewModel) => viewModel.isLoading()
      ? const SizedBox(width: double.infinity, height: 200)
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBasic(
              text: 'Araçlarım',
              color: R.themeColor.smoke,
              fontFamily: R.fonts.displayBold,
              fontSize: 16,
            ),
            const SizedBox(height: 20),
            if (isWeb(context))
              IntrinsicHeight(
                child: Row(
                  children: _getContent(context, viewModel).map((e) => Expanded(child: e)).toList(),
                ),
              )
            else
              Wrap(
                children: _getContent(context, viewModel).map((e) => SizedBox(width: (fragmentWidth(context) - 40) / 2, child: e)).toList(),
              ),
          ],
        );

  List<Widget> _getContent(BuildContext context, VmWidgetForMeVehicle viewModel) => [
        _getBox(context, viewModel.data?.marketPlaceCount ?? 0, 'İlandaki Araçlar', 4),
        _getBox(context, viewModel.data?.inventoryCount ?? 0, 'Envanterimdeki Araçlar', 9),
        _getBox(context, viewModel.data?.consigneeCount ?? 0, 'Konsinye Araçlar', 7),
        _getBox(context, viewModel.data?.vehicleCount ?? 0, 'İlandaki Araçlar', 4),
      ];

  Widget _getBox(BuildContext context, int count, String title, int routeIndex) => InkWell(
        onTap: () => di<ServiceApp>(context).tabsRouter.setActiveIndex(routeIndex),
        focusColor: R.color.transparent,
        splashColor: R.color.transparent,
        highlightColor: R.color.transparent,
        hoverColor: R.color.transparent,
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: R.themeColor.boxBg,
          ),
          child: Column(
            children: [
              TextBasic(
                text: count.toString(),
                color: R.themeColor.secondaryHover,
                fontFamily: R.fonts.displayBold,
                fontSize: 32,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              TextBasic(
                text: title,
                color: R.themeColor.secondary,
                fontSize: 14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              TextBasic(
                text: 'Araçları Gör',
                color: R.themeColor.primary,
                fontSize: 12,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}

class VmWidgetForMeVehicle extends ViewModelBase {
  VmWidgetForMeVehicle(this.serviceApi) {
    init();
  }

  final ServiceApi serviceApi;

  ModelVehicleCountDetail? data;

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getVehicleCountDetail().then(
      (response) {
        data = response.data;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }
}
