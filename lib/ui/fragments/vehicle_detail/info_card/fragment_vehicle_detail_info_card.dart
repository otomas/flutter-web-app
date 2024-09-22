import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/extensions/extension_balance.dart';
import '../../../../core/resources/_r.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widget_info_card_item.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_vehicle_detail_bar.dart';
import '../../../widgets/widget_vehicle_detail_card.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_vehicle_detail_info_card.dart';

@RoutePage()
class FragmentVehicleDetailInfoCard extends StatefulWidget {
  const FragmentVehicleDetailInfoCard({
    @PathParam.inherit('vehicleId') required this.id,
    @QueryParam('branchId') this.branchId,
    super.key,
  });

  final int id;
  final int? branchId;

  @override
  State<FragmentVehicleDetailInfoCard> createState() => _FragmentVehicleDetailInfoCardState();
}

class _FragmentVehicleDetailInfoCardState extends WidgetBaseStatefull<FragmentVehicleDetailInfoCard, VmFragmentVehicleDetailInfoCard> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentVehicleDetailInfoCard createViewModel(BuildContext context) => VmFragmentVehicleDetailInfoCard(apiService(context), widget.id);

  @override
  Widget buildWidget(BuildContext context, VmFragmentVehicleDetailInfoCard viewModel) => Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        child: WidgetVehicleDetailCard(
          title: 'Araç Bilgi Kartı',
          child: ScrollWithNoGlowWidget(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getVehicleInfo(context, viewModel),
                const SizedBox(height: 30),
                _getInfoCards(context, viewModel),
              ],
            ),
          ),
        ),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentVehicleDetailInfoCard viewModel) => buildWidget(context, viewModel);

  Widget _getVehicleInfo(BuildContext context, VmFragmentVehicleDetailInfoCard viewModel) => WidgetVehicleDetailBar(
        imageUrl: viewModel.data?.coverPhotoUrl,
        plate: viewModel.data?.plateNumber,
        title: '${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''} ${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''}',
        subtitle: '${viewModel.data?.vehicleVersion?.vehicleModel?.name ?? ''} ${viewModel.data?.vehicleVersion?.name ?? ''}',
        price: viewModel.data?.price,
        salesPrice: viewModel.data?.salesPrice,
      );

  Widget _getInfoCards(BuildContext context, VmFragmentVehicleDetailInfoCard viewModel) => Column(
        children: [
          ScrollWithNoGlowWidget(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  width: isWeb(context) ? size(context).width / 3.0 : size(context).width - 200,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: R.themeColor.borderLight),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: TextBasic(
                          text: 'Kart ${index + 1}',
                          color: R.color.gray,
                          fontFamily: R.fonts.displayMedium,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: size(context).width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: R.themeColor.boxBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: TextBasic(
                            text: 'Logo',
                            color: R.themeColor.primary,
                            fontFamily: R.fonts.displayBold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      WidgetInfoCardItem(value: viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? '-', isHighlighted: true),
                      WidgetInfoCardItem(value: viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? '-'),
                      WidgetInfoCardItem(value: viewModel.data?.vehicleVersion?.vehicleModel?.name ?? '-'),
                      WidgetInfoCardItem(value: '${viewModel.data?.vehicleFuelType?.name ?? '-'} / ${viewModel.data?.vehicleTransmissionType?.name ?? '-'}'),
                      WidgetInfoCardItem(value: '${viewModel.data?.modelYear ?? '-'} Model / ${viewModel.data?.kilometer ?? '-'} km'),
                      WidgetInfoCardItem(value: '${viewModel.data?.engineCapacity ?? '-'} cc / ${viewModel.data?.enginePower ?? '-'} hp'),
                      WidgetInfoCardItem(value: '${viewModel.data?.vehicleTractionType?.name ?? '-'} / ${viewModel.data?.vehicleBodyType?.name ?? '-'}'),
                      const WidgetInfoCardItem(value: 'Takas Olur'),
                      WidgetInfoCardItem(value: viewModel.data?.salesPrice.formatPrice() ?? '-', isPrice: true, isActiveDivider: false),
                      const SizedBox(height: 20),
                      Center(child: SvgPicture.asset(R.drawable.svg.logo, height: 20)),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
