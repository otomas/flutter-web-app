import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_balance.dart';
import '../../core/extensions/extension_num.dart';
import '../../core/models/model_public_vehicle_card_detail.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widget_button.dart';
import 'widget_image.dart';
import 'widgets_text.dart';

class WidgetPublicNewAds extends WidgetBase<VmWidgetPublicNewAds> {
  const WidgetPublicNewAds({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetPublicNewAds createViewModel(BuildContext context) => VmWidgetPublicNewAds(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetPublicNewAds viewModel) => _getCardList(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetPublicNewAds viewModel) => _getCardList(context, viewModel);

  Widget _getCardList(BuildContext context, VmWidgetPublicNewAds viewModel) => viewModel.isLoading()
      ? const SizedBox(width: double.infinity, height: 300)
      : Row(
          children: [
            ...List.generate(
              viewModel.data.length,
              (index) => Row(
                children: [
                  if (index < 3) _getCard(context, viewModel, index),
                  if (index != 2 && index < 3) const SizedBox(width: 12),
                ],
              ),
            ),
          ],
        );

  Widget _getCard(BuildContext context, VmWidgetPublicNewAds viewModel, int index) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetworkImageWithPlaceholder(
                height: 200,
                width: (size(context).width - (size(context).width * 0.12 + 102)) / 3,
                imageUrl: viewModel.data[index].photos.first.photo680x428Url ?? '',
                radius: 12,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextBasic(
                      text: viewModel.data[index].modelName ?? '',
                      color: R.themeColor.secondary,
                      fontFamily: R.fonts.displayBold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  TextBasic(text: viewModel.data[index].modelYear ?? '', color: R.themeColor.secondary),
                  const SizedBox(width: 10),
                  TextBasic(text: viewModel.data[index].kilometer.formatPrice(), color: R.themeColor.secondary),
                  const SizedBox(width: 10),
                  TextBasic(text: viewModel.data[index].fuelTypeName ?? '', color: R.themeColor.secondary),
                  const SizedBox(width: 10),
                  TextBasic(text: viewModel.data[index].transmissionTypeName ?? '', color: R.themeColor.secondary),
                ],
              ),
              const SizedBox(height: 5),
              TextBasic(text: viewModel.data[index].priceForeign.formatPrice(), color: R.themeColor.secondary, fontFamily: R.fonts.displayBold, fontSize: 22),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonBasic(
                    text: viewModel.data[index].autoGalleryName ?? '',
                    bgColor: R.themeColor.primaryLight,
                    textColor: R.themeColor.primary,
                    onPressed: () {},
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: R.themeColor.error),
                      TextBasic(text: viewModel.data[index].location ?? '', color: R.themeColor.secondary),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class VmWidgetPublicNewAds extends ViewModelBase {
  VmWidgetPublicNewAds(this.serviceApi) {
    unawaited(init());
  }

  final ServiceApi serviceApi;
  List<ModelPublicVehicleCardDetail> data = [];

  @override
  Future<void> init() async {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getPublicVehicleCards().then(
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
