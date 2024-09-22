import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/extensions/extension_bool.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/services/router/router.gr.dart' as routergr;
import '../../../base/base_view.dart';
import '../../../widgets/activity_indicator.dart';
import '../../../widgets/widget_button.dart';
import '../../../widgets/widget_data_table.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_textfield.dart';
import '../../../widgets/widget_vehicle.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_vehicles_sold.dart';

@RoutePage()
class FragmentVehicleSold extends StatefulWidget {
  const FragmentVehicleSold({
    super.key,
    @QueryParam('page') this.page,
    @QueryParam('orderByDirection') this.orderByDirection,
    @QueryParam('orderByField') this.orderByField,
  });

  final int? page;
  final String? orderByField;
  final String? orderByDirection;

  @override
  State<FragmentVehicleSold> createState() => _FragmentVehicleSoldState();
}

class _FragmentVehicleSoldState extends WidgetBaseStatefull<FragmentVehicleSold, VmFragmentVehicleSold> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentVehicleSold createViewModel(BuildContext context) => VmFragmentVehicleSold(apiService(context), widget.orderByField, widget.orderByDirection);

  @override
  Widget buildWidget(BuildContext context, VmFragmentVehicleSold viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentVehicleSold viewModel) => _getBodyWeb(context, viewModel);

  Widget _getBody(BuildContext context, VmFragmentVehicleSold viewModel) => ScrollWithNoGlowWidget(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _getSearchField(context, viewModel),
            const SizedBox(height: 20),
            _getVehicles(context, viewModel),
            const SizedBox(height: 120),
          ],
        ),
      );

  Widget _getBodyWeb(BuildContext context, VmFragmentVehicleSold viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextBasic(text: 'Sattığım Araçlar', color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayBold, fontSize: 24),
            const SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(child: _getSearchField(context, viewModel)),
                  const SizedBox(width: 10),
                  WidgetOptionIconButton(svgPath: R.drawable.svg.iconExport, onPressed: () {}),
                  const SizedBox(width: 10),
                  WidgetOptionIconButton(svgPath: R.drawable.svg.iconShare, onPressed: () {}),
                  const SizedBox(width: 10),
                  WidgetOptionIconButton(svgPath: R.drawable.svg.iconPrint, onPressed: () {}),
                ],
              ),
            ),
            _getWebList(context, viewModel),
          ],
        ),
      );

  Widget _getSearchField(BuildContext context, VmFragmentVehicleSold viewModel) => TextFieldBasic(
        controller: viewModel.searchController,
        hintText: R.string.searchForVehicles,
        padding: EdgeInsets.zero,
        suffixIcon: viewModel.isLoadingPagination ? IOSIndicator(color: R.themeColor.secondary) : Icon(Icons.search, color: R.themeColor.primary),
      );

  Widget _getWebList(BuildContext context, VmFragmentVehicleSold viewModel) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: WidgetDataTable(
            data: viewModel.tableData,
            tableController: viewModel.tableController,
            take: viewModel.take,
            onTapCellItem: (index) => unawaited(router(context).startNewView(route: routergr.RouteVehicleDetail(vehicleId: viewModel.data[index].id, branchId: viewModel.data[index].autoGalleryBranchId))),
            fetcher: (pageSize, sortModel, filterModel, pageToken) async {
              final direction = sortModel?.descending.getOrderDirection(sortModel.fieldName);
              if (sortModel?.fieldName != null && (sortModel?.fieldName != viewModel.orderByField || direction != viewModel.orderByDirection)) {
                unawaited(router(context).startNewView(route: routergr.FragmentVehicleSold(orderByField: sortModel?.fieldName, orderByDirection: direction)));
                return (<Widget>[], '1');
              }
              final data = await viewModel.getData(length: pageSize, sort: sortModel, pageToken: pageToken);
              return (data.first.widgets, (viewModel.totalListCount ?? 0) > ((viewModel.page + 1) * pageSize) ? viewModel.page.toString() : null);
            },
          ),
        ),
      );

  Widget _getVehicles(BuildContext context, VmFragmentVehicleSold viewModel) => ListView.builder(
        itemCount: viewModel.data.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final item = viewModel.data[index];
          return WidgetVehicle(item: item, isActiveBorder: index != viewModel.data.length - 1);
        },
      );
}
