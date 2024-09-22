import 'package:flutter/widgets.dart';

import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetInfoBox extends StatelessWidget {
  const WidgetInfoBox({
    required this.title,
    required this.bgColor,
    required this.textColor,
    super.key,
  });

  final String title;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor,
        ),
        child: TextBasic(
          text: title,
          color: textColor,
          fontFamily: R.fonts.displayBold,
          fontSize: 14,
        ),
      );
}
