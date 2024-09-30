import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/utils/formatters.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widget_app_bar.dart';
import '../../../widgets/widget_button.dart';
import '../../../widgets/widget_expandable.dart';
import '../../../widgets/widget_flexible.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_textfield.dart';
import '../../../widgets/widget_vehicle_detail_bar.dart';
import '../../../widgets/widget_vehicle_detail_card.dart';
import '../../../widgets/widget_web.dart';
import '../../../widgets/widgets_text.dart';
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
  Widget buildWidgetForWeb(BuildContext context, VmVehicleDoping viewModel) => Scaffold(
        body: WidgetWebBase(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: size(context).width * 0.06),
              Expanded(flex: 8, child: _getContent(context, viewModel)),
              const SizedBox(width: 30),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: R.themeColor.viewBg,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 34,
                        color: R.themeColor.viewText.withOpacity(0.24),
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: _getActionMenu(context, viewModel),
                ),
              ),
              SizedBox(width: size(context).width * 0.06),
            ],
          ),
        ),
      );

  @override
  Widget buildWidget(BuildContext context, VmVehicleDoping viewModel) => Scaffold(
        appBar: isWeb(context) ? null : const WidgetAppBarBasic(title: 'Araç Dopingle'),
        body: _getContent(context, viewModel),
      );

  Widget _getActionMenu(BuildContext context, VmVehicleDoping viewModel) => Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBasic(text: 'Bu İlana Doping Satın Al', color: R.themeColor.smokeDark, fontFamily: R.fonts.displayBold, fontSize: 18),
              const SizedBox(height: 20),
            ],
          ),
        ],
      );

  Widget _getContent(BuildContext context, VmVehicleDoping viewModel) => ScrollWithNoGlowWidget(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: WidgetVehicleDetailCard(
          title: 'İlanınızın Durumunu Kontrol Edin',
          children: [
            _getHeader(context, viewModel),
            _getPriceBoxs(context, viewModel),
            _getAdInfoFields(context, viewModel),
          ],
        ),
      );

  Widget _getHeader(BuildContext context, VmVehicleDoping viewModel) => IntrinsicHeight(
        child: WidgetFlexible(
          isRow: isWeb(context),
          children: [
            WidgetExpandable(
              flex: 4,
              isExpanded: isWeb(context),
              child: WidgetVehicleDetailBar(
                imageUrl: viewModel.data?.coverPhotoUrl,
                plate: viewModel.data?.plateNumber,
                title: '${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''} ${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''}',
                subtitle: '${viewModel.data?.vehicleVersion?.vehicleModel?.name ?? ''} ${viewModel.data?.vehicleVersion?.name ?? ''}',
              ),
            ),
            VerticalDivider(color: R.themeColor.borderLight),
            const SizedBox(width: 20),
            Expanded(flex: 2, child: _getAdPublishStatus(context, viewModel)),
          ],
        ),
      );

  Widget _getAdPublishStatus(BuildContext context, VmVehicleDoping viewModel) => Column(
        children: [
          ValueListenableBuilder(
            valueListenable: viewModel.isPublishPriceDomestic,
            builder: (context, value, child) => SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              applyCupertinoTheme: true,
              value: value,
              onChanged: viewModel.setIsPublishPriceDomestic,
              title: Row(
                children: [
                  Expanded(child: Container()),
                  TextBasic(
                    text: 'İç Pazarda Göster',
                    color: R.themeColor.smokeDark,
                    fontFamily: R.fonts.displayMedium,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Divider(color: R.themeColor.border),
          ValueListenableBuilder(
            valueListenable: viewModel.isPublishPriceForeign,
            builder: (context, value, child) => SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              applyCupertinoTheme: true,
              value: value,
              onChanged: viewModel.setIsPublishPriceForeign,
              title: Row(
                children: [
                  Expanded(child: Container()),
                  TextBasic(
                    text: 'Dış Pazarda Göster',
                    color: R.themeColor.smokeDark,
                    fontFamily: R.fonts.displayMedium,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _getPriceBoxs(BuildContext context, VmVehicleDoping viewModel) => WidgetFlexible(
        isRow: isWeb(context),
        children: [
          WidgetExpandable(
            isExpanded: isWeb(context),
            child: TextFieldBasic(
              controller: viewModel.buyingPriceController,
              title: 'Aracın Alış Fiyatı',
              keyboardType: TextInputType.number,
              fontFamily: R.fonts.displayBold,
              inputFormatters: [DecimalFormatter()],
              hasError: viewModel.isDetectError && viewModel.checkErrorByField('price'),
              errorLabel: viewModel.getErrorMsg('price'),
              hintText: '0.00',
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextBasic(text: '₺', fontFamily: R.fonts.displayBold),
              ),
            ),
          ),
          const SizedBox(width: 20, height: 20),
          WidgetExpandable(
            isExpanded: isWeb(context),
            child: TextFieldBasic(
              controller: viewModel.domesticPriceController,
              title: 'Aracın İç Piyasa Fiyatı',
              titleColor: R.themeColor.primary,
              textColor: R.themeColor.primary,
              keyboardType: TextInputType.number,
              fontFamily: R.fonts.displayBold,
              inputFormatters: [DecimalFormatter()],
              hasError: viewModel.isDetectError && viewModel.checkErrorByField('price_domestic'),
              errorLabel: viewModel.getErrorMsg('price_domestic'),
              hintText: '0.00',
              labelTextColor: R.themeColor.primary,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextBasic(text: '₺', fontFamily: R.fonts.displayBold, color: R.themeColor.primary),
              ),
            ),
          ),
          const SizedBox(width: 20, height: 20),
          WidgetExpandable(
            isExpanded: isWeb(context),
            child: TextFieldBasic(
              controller: viewModel.foreignPriceController,
              title: 'Aracın Dış Piyasa Fiyatı',
              titleColor: R.themeColor.success,
              textColor: R.themeColor.success,
              keyboardType: TextInputType.number,
              fontFamily: R.fonts.displayBold,
              inputFormatters: [DecimalFormatter()],
              hasError: viewModel.isDetectError && viewModel.checkErrorByField('price_foreign'),
              errorLabel: viewModel.getErrorMsg('price_foreign'),
              hintText: '0.00',
              labelTextColor: R.themeColor.success,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextBasic(text: '₺', fontFamily: R.fonts.displayBold, color: R.themeColor.success),
              ),
            ),
          ),
        ],
      );

  Widget _getAdInfoFields(BuildContext context, VmVehicleDoping viewModel) => Column(
        children: [
          TextFieldBasic(
            // enabled: !widget.isArchive,
            controller: viewModel.titleController,
            title: 'İlan Başlığı',
            hasError: viewModel.isDetectError && viewModel.checkErrorByField('title'),
            errorLabel: viewModel.getErrorMsg('title'),
          ),
          const SizedBox(height: 20),
          TextFieldBasic(
            // enabled: !widget.isArchive,
            controller: viewModel.descriptionController,
            title: 'İlan Açıklaması',
            textColor: R.themeColor.secondaryHover,
            maxLines: 6,
            hasError: viewModel.isDetectError && viewModel.checkErrorByField('description'),
            errorLabel: viewModel.getErrorMsg('description'),
          ),
          const SizedBox(height: 20),
          _getButtons(context, viewModel),
        ],
      );

  Widget _getButtons(BuildContext context, VmVehicleDoping viewModel) => Row(
        children: [
          const Expanded(child: SizedBox()),
          ButtonBasic(
            onPressed: () {},
            text: 'Kaydet',
            bgColor: R.themeColor.success,
            textColor: R.themeColor.viewBg,
          ),
        ],
      );
}
