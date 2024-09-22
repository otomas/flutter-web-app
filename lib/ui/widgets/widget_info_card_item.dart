import 'package:flutter/cupertino.dart';

import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetInfoCardItem extends StatelessWidget {
  const WidgetInfoCardItem({
    required this.value,
    super.key,
    this.title,
    this.isActiveDivider = true,
    this.isHighlighted = false,
    this.isPrice = false,
  });
  final String? title;
  final String value;
  final bool isActiveDivider;
  final bool isHighlighted;
  final bool isPrice;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: !isActiveDivider ? null : Border(bottom: BorderSide(color: R.themeColor.borderLight)),
        ),
        child: Row(
          children: [
            if (title != null)
              TextBasic(
                text: title!,
                color: R.themeColor.secondary,
              ),
            Expanded(
              child: Center(
                child: TextBasic(
                  text: value,
                  color: isPrice ? R.color.candy : R.themeColor.secondary,
                  fontFamily: isHighlighted || isPrice ? R.fonts.displayBold : R.fonts.displayMedium,
                  fontSize: isHighlighted || isPrice ? 24.0 : 16.0,
                ),
              ),
            ),
          ],
        ),
      );
}
