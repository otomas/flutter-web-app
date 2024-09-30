import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/services/router/router.gr.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_balance.dart';
import '../../core/models/model_public_vehicle_card_detail.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widget_button.dart';
import 'widget_image.dart';
import 'widget_scroll.dart';
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
  Widget buildWidget(BuildContext context, VmWidgetPublicNewAds viewModel) =>
      ScrollWithNoGlowWidget(scrollDirection: Axis.horizontal, child: _getCardList(context, viewModel));

  Widget _getCardList(BuildContext context, VmWidgetPublicNewAds viewModel) =>
      viewModel.isLoading() ? const SizedBox(width: double.infinity, height: 300) : _getContent(context, viewModel);

  Widget _getContent(BuildContext context, VmWidgetPublicNewAds viewModel) => Row(
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

  Widget _getCard(BuildContext context, VmWidgetPublicNewAds viewModel, int index) => InkWell(
        onTap: () async => unawaited(
          router(context).startNewView(
            route: RoutePublicDetail(vehicleId: viewModel.data[index].id ?? -1),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: R.themeColor.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: _cardInfo(context, viewModel, index),
        ),
      );

  Widget _cardInfo(BuildContext context, VmWidgetPublicNewAds viewModel, int index) => SizedBox(
        width:
            isWeb(context) ? (size(context).width - (size(context).width * 0.12 + 102)) / 3 : (size(context).width - (size(context).width * 0.12 + 20)) / 1.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetworkImageWithPlaceholder(
              height: 200,
              width: double.infinity,
              imageUrl: viewModel.data[index].photos.first.photo680x428Url ?? '',
              radius: 12,
            ),
            const SizedBox(height: 5),
            TextBasic(
              text: viewModel.data[index].modelName ?? '',
              color: R.themeColor.secondary,
              fontFamily: R.fonts.displayBold,
              fontSize: 14,
            ),
            const SizedBox(height: 5),
            TextBasic(
              text: viewModel.data[index].shortInfo,
              color: R.themeColor.secondary,
              fontSize: 12,
            ),
            const SizedBox(height: 5),
            TextBasic(
              text: viewModel.data[index].priceForeign.formatPrice(),
              color: R.themeColor.secondary,
              fontFamily: R.fonts.displayBold,
              fontSize: isWeb(context) ? 22 : 18,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ButtonBasic(
                    bgColor: R.themeColor.primaryLight,
                    textColor: R.themeColor.primary,
                    onPressed: () {},
                    textBasic: TextBasic(
                      text: viewModel.data[index].autoGalleryName ?? '',
                      color: R.themeColor.primary,
                      fontFamily: R.fonts.displayBold,
                      maxLines: 2,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.location_on, color: R.themeColor.error),
                      TextBasic(text: viewModel.data[index].location ?? '', color: R.themeColor.secondary),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
