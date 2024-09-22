import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/models/model_alert_dialog.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/services/router/router.gr.dart';
import '../../../../core/utils/alert_utils.dart';
import '../../../../core/utils/formatters.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widget_button.dart';
import '../../../widgets/widget_expandable.dart';
import '../../../widgets/widget_flexible.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_textfield.dart';
import '../../../widgets/widget_vehicle_detail_bar.dart';
import '../../../widgets/widget_vehicle_detail_card.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_vehicle_detail_ad_info.dart';

@RoutePage()
class FragmentVehicleDetailAdInfo extends StatefulWidget {
  const FragmentVehicleDetailAdInfo({
    @PathParam.inherit('vehicleId') required this.id,
    @QueryParam('branchId') this.branchId,
    super.key,
  });

  final int id;
  final int? branchId;

  @override
  State<FragmentVehicleDetailAdInfo> createState() => _FragmentVehicleDetailAdInfoState();
}

class _FragmentVehicleDetailAdInfoState extends WidgetBaseStatefull<FragmentVehicleDetailAdInfo, VmFragmentVehicleDetailAdInfo> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentVehicleDetailAdInfo createViewModel(BuildContext context) => VmFragmentVehicleDetailAdInfo(apiService(context), widget.id);

  @override
  Widget buildWidget(BuildContext context, VmFragmentVehicleDetailAdInfo viewModel) => Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        child: WidgetVehicleDetailCard(
          title: 'İlan Bilgileri',
          child: ScrollWithNoGlowWidget(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getVehicleInfo(context, viewModel),
                const SizedBox(height: 30),
                _getVehicleDescInputs(context, viewModel),
              ],
            ),
          ),
        ),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentVehicleDetailAdInfo viewModel) => buildWidget(context, viewModel);

  Widget _getVehicleInfo(BuildContext context, VmFragmentVehicleDetailAdInfo viewModel) => WidgetVehicleDetailBar(
        imageUrl: viewModel.data?.coverPhotoUrl,
        plate: viewModel.data?.plateNumber,
        title: '${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''} ${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''}',
        subtitle: '${viewModel.data?.vehicleVersion?.vehicleModel?.name ?? ''} ${viewModel.data?.vehicleVersion?.name ?? ''}',
      );

  Widget _getVehicleDescInputs(BuildContext context, VmFragmentVehicleDetailAdInfo viewModel) => Container(
        width: size(context).width,
        decoration: BoxDecoration(
          color: R.color.white,
          border: Border(bottom: BorderSide(color: R.themeColor.borderLight)),
        ),
        child: Column(
          children: [
            WidgetFlexible(
              isRow: isWeb(context),
              children: [
                WidgetExpandable(
                  isExpanded: isWeb(context),
                  child: TextFieldBasic(
                    // enabled: !widget.isArchive,
                    controller: viewModel.titleController,
                    title: 'İlan Başlığı',
                    hasError: viewModel.isDetectError && viewModel.checkErrorByField('title'),
                    errorLabel: viewModel.getErrorMsg('title'),
                  ),
                ),
                const SizedBox(height: 15, width: 15),
                WidgetExpandable(
                  isExpanded: isWeb(context),
                  child: TextFieldBasic(
                    // enabled: !widget.isArchive,
                    controller: viewModel.foreignPriceController,
                    title: 'Dış Piyasa Fiyatı',
                    keyboardType: TextInputType.number,
                    textColor: R.themeColor.secondaryHover,
                    textAlign: TextAlign.end,
                    fontFamily: R.fonts.displayBold,
                    suffixIcon: TextBasic(text: '₺', color: R.themeColor.smokeDark),
                    hasError: viewModel.isDetectError && viewModel.checkErrorByField('price_foreign'),
                    errorLabel: viewModel.getErrorMsg('price_foreign'),
                    inputFormatters: [DecimalFormatter()],
                  ),
                ),
                const SizedBox(height: 15, width: 15),
                WidgetExpandable(
                  isExpanded: isWeb(context),
                  child: TextFieldBasic(
                    // enabled: !widget.isArchive,
                    controller: viewModel.domesticPriceController,
                    title: 'İç Piyasa Fiyatı',
                    keyboardType: TextInputType.number,
                    textColor: R.color.river,
                    textAlign: TextAlign.end,
                    fontFamily: R.fonts.displayBold,
                    suffixIcon: TextBasic(text: '₺', color: R.themeColor.smokeDark),
                    hasError: viewModel.isDetectError && viewModel.checkErrorByField('price_domestic'),
                    errorLabel: viewModel.getErrorMsg('price_domestic'),
                    inputFormatters: [DecimalFormatter()],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextFieldBasic(
              // enabled: !widget.isArchive,
              controller: viewModel.descriptionController,
              title: 'İlan Açıklaması',
              textColor: R.themeColor.secondaryHover,
              maxLines: 6,
              hasError: viewModel.isDetectError && viewModel.checkErrorByField('description'),
              errorLabel: viewModel.getErrorMsg('description'),
            ),
            const SizedBox(height: 15),
            // if (!widget.isArchive)
            Row(
              children: [
                Expanded(child: Container()),
                ButtonBasic(
                  onPressed: () async {
                    if (await viewModel.saveInfo() && context.mounted) {
                      unawaited(showPlatformAlert(context, const ModelAlertDialog(description: 'Bilgiler kaydedildi', dialogType: DialogTypes.success)));
                      unawaited(router(context).startNewView(route: RouteVehicleDetail(vehicleId: widget.id, branchId: widget.branchId), isReplace: true));
                    }
                  },
                  text: 'Değişiklikleri Kaydet',
                  bgColor: R.themeColor.successLight,
                  textColor: R.color.river,
                ),
              ],
            ),
          ],
        ),
      );
}
