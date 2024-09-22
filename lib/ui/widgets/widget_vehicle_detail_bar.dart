import 'package:flutter/material.dart';

import '../../core/extensions/extension_balance.dart';
import '../../core/models/model_balance.dart';
import '../../core/resources/_r.dart';
import '../base/base_view.dart';
import 'widget_expandable.dart';
import 'widget_flexible.dart';
import 'widget_image.dart';
import 'widgets_text.dart';

class WidgetVehicleDetailBar extends StatelessWidget with BaseView {
  const WidgetVehicleDetailBar({super.key, this.imageUrl, this.plate, this.title, this.subtitle, this.price, this.salesPrice});

  final String? imageUrl;
  final String? plate;
  final String? title;
  final String? subtitle;
  final ModelBalance? price;
  final ModelBalance? salesPrice;

  @override
  Widget build(BuildContext context) => WidgetFlexible(
        isRow: isWeb(context),
        crossAxisAlignment: isWeb(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          NetworkImageWithPlaceholder(
            height: isWeb(context) ? 180 : 250,
            width: isWeb(context) ? 320 : double.infinity,
            radius: 12,
            imageUrl: imageUrl,
          ),
          const SizedBox(width: 10, height: 15),
          WidgetExpandable(
            isExpanded: isWeb(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBasic(text: plate ?? '-', color: R.themeColor.smoke, fontFamily: R.fonts.displayMedium, fontSize: 16),
                const SizedBox(height: 5),
                TextBasic(
                  text: title ?? '-',
                  color: R.themeColor.secondary,
                  fontFamily: R.fonts.displayBold,
                  fontSize: 18,
                ),
                const SizedBox(height: 5),
                TextBasic(
                  text: subtitle ?? '-',
                  color: R.themeColor.secondary,
                  fontFamily: R.fonts.displayMedium,
                  fontSize: 18,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16, height: 16),
          WidgetExpandable(
            isExpanded: isWeb(context),
            child: WidgetFlexible(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              isRow: true,
              children: [
                if (price != null)
                  WidgetExpandable(
                    isExpanded: !isWeb(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: R.themeColor.border, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          TextBasic(
                            text: 'Alış Fiyatı',
                            color: R.themeColor.smoke,
                            fontFamily: R.fonts.displayMedium,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 5),
                          TextBasic(
                            text: price!.formatPrice(),
                            color: R.themeColor.error,
                            fontFamily: R.fonts.displayBold,
                            fontSize: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (salesPrice != null && price != null) const SizedBox(width: 10),
                if (salesPrice != null)
                  WidgetExpandable(
                    isExpanded: !isWeb(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: R.themeColor.border,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          TextBasic(
                            text: 'Satış Fiyatı',
                            color: R.themeColor.smoke,
                            fontFamily: R.fonts.displayMedium,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 5),
                          TextBasic(
                            text: salesPrice!.formatPrice(),
                            color: R.themeColor.success,
                            fontFamily: R.fonts.displayBold,
                            fontSize: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
}
