import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/extensions/extension_balance.dart';
import '../../core/models/model_vehicle.dart';
import '../../core/models/model_vehicle_archive.dart';
import '../../core/resources/_r.dart';
import '../../core/services/router/router.gr.dart';
import '../../core/services/service_route.dart';
import 'widget_button.dart';
import 'widget_image.dart';
import 'widgets_text.dart';

class WidgetVehicle extends StatelessWidget {
  const WidgetVehicle({required this.item, super.key, this.isActiveBorder = true, this.isArchive = false, this.onTap});
  final ModelVehicle item;
  final bool isActiveBorder;
  final bool isArchive;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: () async {
        final v = await Provider.of<ServiceRoute>(context, listen: false).startNewView(route: RouteVehicleDetail(vehicleId: item.id, branchId: item.autoGalleryBranchId));
        if (v != null && v is bool && v && onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: !isActiveBorder ? null : Border(bottom: BorderSide(color: R.themeColor.secondaryLight)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NetworkImageWithPlaceholder(height: 80, width: 120, imageUrl: item.avatar, radius: 10),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBasic(text: item.plateNumber ?? '', color: R.themeColor.smoke, fontSize: 12),
                      const SizedBox(height: 5),
                      TextBasic(text: item.brandFullName, color: R.themeColor.secondary, fontSize: 14, fontFamily: R.fonts.displayMedium),
                      const SizedBox(height: 5),
                      TextBasic(text: item.vehicleVersion?.vehicleModel?.name ?? '', color: R.themeColor.secondary, fontSize: 12),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: R.themeColor.smoke),
              ],
            ),
            const SizedBox(height: 10),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: WidgetInfoCardText(
                      title: R.string.customer,
                      value: item.seller?.fullName ?? '',
                    ),
                  ),
                  const SizedBox(width: 10),
                  WidgetInfoCardText(
                    title: R.string.vehiclePrice,
                    value: item.salesPrice.formatPrice(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: WidgetInfoCardText(
                      title: R.string.supplier,
                      value: item.supplier?.fullName ?? '',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}

class WidgetVehicleArchive extends StatelessWidget {
  const WidgetVehicleArchive({required this.item, required this.onPressedItem, super.key, this.onPressedRemoveArchive, this.isActiveBorder = true});
  final ModelVehicleArchive item;
  final bool isActiveBorder;
  final Function()? onPressedRemoveArchive;
  final Function() onPressedItem;

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onPressedItem,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: !isActiveBorder ? null : Border(bottom: BorderSide(color: R.themeColor.secondaryLight)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NetworkImageWithPlaceholder(height: 80, width: 120, imageUrl: item.imageUrl, radius: 10),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBasic(text: item.plate, color: R.themeColor.smoke, fontSize: 12),
                      const SizedBox(height: 5),
                      TextBasic(text: item.brand, color: R.themeColor.secondary, fontSize: 14, fontFamily: R.fonts.displayMedium),
                      const SizedBox(height: 5),
                      TextBasic(text: item.model, color: R.themeColor.secondary, fontSize: 12),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: R.themeColor.smoke),
              ],
            ),
            const SizedBox(height: 10),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: WidgetInfoCardText(
                      title: R.string.supplier,
                      value: item.supplier,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: WidgetInfoCardText(
                      title: R.string.seller,
                      value: item.seller,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: WidgetInfoCardText(
                      title: R.string.balance,
                      value: '${item.balance} ${item.balanceCurrency}',
                      valueColor: R.color.candy,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(child: Container()),
                  ButtonBasic(
                    onPressed: onPressedRemoveArchive,
                    bgColor: R.themeColor.warningLight,
                    radius: 12,
                    text: R.string.removeArchive,
                    textColor: R.color.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
