import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/models/model_vehicle_equipment.dart';
import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetVehicleEquipmentList extends StatelessWidget {
  const WidgetVehicleEquipmentList({required this.items, super.key});
  final List<ModelVehicleEquipment> items;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i != 0) const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: TextBasic(
                    text: items[i].name ?? '',
                    color: R.themeColor.secondary,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  color:  R.themeColor.success,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 5),
            if (i != items.length - 1) Divider(color: R.themeColor.border),
          ],
        ],
      );
}
