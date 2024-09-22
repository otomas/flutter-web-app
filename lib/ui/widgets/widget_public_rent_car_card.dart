import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_balance.dart';
import '../../core/models/model_vehicle.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widget_button.dart';
import 'widget_image.dart';
import 'widgets_text.dart';

class WidgetPublicRentCarCard extends WidgetBase<VmWidgetPublicRentCarCard> {
  const WidgetPublicRentCarCard({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

   @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetPublicRentCarCard createViewModel(BuildContext context) => VmWidgetPublicRentCarCard(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetPublicRentCarCard viewModel) => _getCardList(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetPublicRentCarCard viewModel) => _getCardList(context, viewModel);

  Widget _getCardList(BuildContext context, VmWidgetPublicRentCarCard viewModel) => viewModel.isLoading()
      ? const SizedBox(width: double.infinity, height: 300)
      : Row(
          children: [
            ...List.generate(
              viewModel.data.length,
              (index) => Row(
                children: [
                  _getCard(context, viewModel, index),
                  if(index != 4) const SizedBox(width: 12),
                ],
              ),
            ),
          ],
        );

  Widget _getCard(BuildContext context, VmWidgetPublicRentCarCard viewModel, int index) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IntrinsicWidth(
          child: Column(
            children: [
              NetworkImageWithPlaceholder(
                height: 200,
                width: (size(context).width - (size(context).width * 0.12 + 180)) / 5,
                imageUrl: viewModel.data[index].avatar,
                radius: 12,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  TextBasic(
                    text:
                        '${viewModel.data[index].vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''} ${viewModel.data[index].vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''}',
                    color: R.themeColor.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  TextBasic(text: viewModel.data[index].vehicleTransmissionType?.name ?? '', color: R.themeColor.secondary),
                  const SizedBox(width: 10),
                  TextBasic(text: viewModel.data[index].vehicleFuelType?.name ?? '', color: R.themeColor.secondary),
                ],
              ),
              const SizedBox(height: 5),
              TextBasic(text: '${viewModel.data[index].price.formatPrice()} / Gün' , color: R.themeColor.secondary, fontFamily: R.fonts.displayBold, fontSize: 22),
              const SizedBox(height: 15),
              ButtonBasic(
                text: 'Hemen Kirala',
                bgColor: R.themeColor.primaryLight,
                textColor: R.themeColor.primary,
                onPressed: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
}

class VmWidgetPublicRentCarCard extends ViewModelBase {
  VmWidgetPublicRentCarCard(this.serviceApi) {
    init();
  }

  final ServiceApi serviceApi;
  List<ModelVehicle> data = [];

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getVehicles(start: 0, length: 5).then(
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
