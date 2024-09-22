import 'package:flutter/cupertino.dart';

import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetExpansionPanelItem extends StatelessWidget {
  const WidgetExpansionPanelItem({
    required this.title,
    super.key,
    this.isActiveDivider = true,
    this.value,
    this.titleFontSize = 14.0,
    this.valueFontSize = 14.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  });
  final String title;
  final String? value;
  final bool isActiveDivider;
  final double titleFontSize;
  final double valueFontSize;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(border: !isActiveDivider ? null : Border(bottom: BorderSide(color: R.themeColor.borderLight))),
        child: Row(
          children: [
            TextBasic(
              text: title,
              fontSize: 14,
              color: R.themeColor.secondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextBasic(
                text: value ?? '-',
                fontSize: valueFontSize,
                color: R.themeColor.secondaryHover,
                fontFamily: R.fonts.displayBold,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      );
}

class WidgetExpansionPanelItemVeritcal extends StatelessWidget {
  const WidgetExpansionPanelItemVeritcal({
    required this.title,
    super.key,
    this.isActiveDivider = true,
    this.value,
  });
  final String title;
  final String? value;
  final bool isActiveDivider;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBasic(
                text: title,
                color: R.themeColor.smoke,
                fontFamily: R.fonts.displayMedium,
              ),
              const SizedBox(height: 5),
              TextBasic(
                text: value ?? '-',
                color: R.themeColor.primary,
                fontFamily: R.fonts.displayBold,
                fontSize: 24,
              ),
            ],
          ),
        ),
      );
}
