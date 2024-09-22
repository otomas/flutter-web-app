import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/extensions/extension_date.dart';
import '../../../../core/extensions/extension_string.dart';
import '../../../../core/resources/_r.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widget_button.dart';
import '../../../widgets/widget_checkbox.dart';
import '../../../widgets/widget_empty_view.dart';
import '../../../widgets/widget_flexible.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_sortable_table.dart';
import '../../../widgets/widget_vehicle_detail_bar.dart';
import '../../../widgets/widget_vehicle_detail_card.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_vehicle_detail_query_part_change.dart';

@RoutePage()
class FragmentVehicleDetailQueryPartChange extends StatefulWidget {
  const FragmentVehicleDetailQueryPartChange({
    @PathParam.inherit('vehicleId') required this.id,
    @QueryParam('branchId') this.branchId,
    super.key,
  });

  final int id;
  final int? branchId;

  @override
  State<FragmentVehicleDetailQueryPartChange> createState() => _FragmentVehicleDetailQueryPartChangeState();
}

class _FragmentVehicleDetailQueryPartChangeState extends WidgetBaseStatefull<FragmentVehicleDetailQueryPartChange, VmFragmentVehicleDetailQueryPartChange> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentVehicleDetailQueryPartChange createViewModel(BuildContext context) => VmFragmentVehicleDetailQueryPartChange(apiService(context), widget.id);

  @override
  Widget buildWidget(BuildContext context, VmFragmentVehicleDetailQueryPartChange viewModel) => Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        child: WidgetVehicleDetailCard(
          title: 'Parça Değişim Kaydı',
          child: ScrollWithNoGlowWidget(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getVehicleInfo(context, viewModel),
                const SizedBox(height: 20),
                Divider(color: R.themeColor.borderLight),
                const SizedBox(height: 20),
                _getQueryTypeSelection(context, viewModel),
                const SizedBox(height: 20),
                Divider(color: R.themeColor.borderLight),
                _getQueries(context, viewModel),
              ],
            ),
          ),
        ),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentVehicleDetailQueryPartChange viewModel) => buildWidget(context, viewModel);

  Widget _getVehicleInfo(BuildContext context, VmFragmentVehicleDetailQueryPartChange viewModel) => WidgetVehicleDetailBar(
        imageUrl: viewModel.vehicleData?.coverPhotoUrl,
        plate: viewModel.vehicleData?.plateNumber,
        title: '${viewModel.vehicleData?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''} ${viewModel.vehicleData?.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''}',
        subtitle: '${viewModel.vehicleData?.vehicleVersion?.vehicleModel?.name ?? ''} ${viewModel.vehicleData?.vehicleVersion?.name ?? ''}',
        price: viewModel.vehicleData?.price,
        salesPrice: viewModel.vehicleData?.salesPrice,
      );

  Widget _getQueryTypeSelection(BuildContext context, VmFragmentVehicleDetailQueryPartChange viewModel) => WidgetFlexible(
        isRow: isWeb(context),
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ScrollWithNoGlowWidget(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(viewModel.queryTypes.length, (index) {
                final item = viewModel.queryTypes[index];
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: CheckboxBasic(
                    key: UniqueKey(),
                    item: viewModel.queryTypes[index],
                    value: viewModel.selectedQueryType == item,
                    onChanged: (v) => viewModel.setSelectedQueryType(item),
                    isRadioButton: true,
                    isInnerScroll: true,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 24),
          ButtonBasic(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            onPressed: () => unawaited(viewModel.createQuery()),
            text: 'Sorgula',
          ),
        ],
      );

  Widget _getQueries(BuildContext context, VmFragmentVehicleDetailQueryPartChange viewModel) => Container(
        width: size(context).width,
        padding: const EdgeInsets.all(20),
        child: viewModel.data.isEmpty
            ? const WidgetEmptyView(
                isExpanded: false,
                title: 'Geçmiş parça değişim sorgunuz bulunmamaktadır.',
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichTextBasic(
                    textAlign: TextAlign.start,
                    texts: 'Geçmiş Parça Değişim Sorgularınız'.highlightOccurrences(
                      'Parça Değişim',
                      textColor: R.themeColor.secondaryHover,
                      boldTextColor: R.themeColor.secondaryHover,
                      fontSize: 16,
                      boldFontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  WidgetSortableTable(
                    key: ValueKey(viewModel.data.length),
                    titles: const ['Tarih', 'Saat', 'Sorgu Tipi'],
                    items: List.generate(
                      viewModel.data.length,
                      (index) {
                        final item = viewModel.data[index];
                        return [
                          item.updatedAt.dayMonthNameAndYear(),
                          item.updatedAt.hourAndMinute(),
                          if (item.plateNumber != null) R.string.plateNumberQuery else R.string.chassisNumberQuery,
                        ];
                      },
                    ),
                    onPressedItem: (rowIndex, columnIndex) {
                      log(viewModel.data[columnIndex].id.toString());
                    },
                  ),
                ],
              ),
      );
}
