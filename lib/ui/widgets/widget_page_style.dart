import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/enums/enum_app.dart';
import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetPageStyle extends StatelessWidget {
  const WidgetPageStyle({required this.selectedPageStyle, required this.onPressedPageStyle, super.key});

  final PageStyle selectedPageStyle;
  final Function(PageStyle) onPressedPageStyle;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          TextBasic(text: 'Görünüm', color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayMedium, fontSize: 12),
          const SizedBox(width: 10),
          InkWell(onTap: () => onPressedPageStyle(PageStyle.twoBox), child: SvgPicture.asset(R.drawable.svg.iconBoxTwo, colorFilter: _getColor(PageStyle.twoBox))),
          const SizedBox(width: 10),
          InkWell(onTap: () => onPressedPageStyle(PageStyle.threeBox), child: SvgPicture.asset(R.drawable.svg.iconBoxThree, colorFilter: _getColor(PageStyle.threeBox))),
          const SizedBox(width: 10),
          InkWell(onTap: () => onPressedPageStyle(PageStyle.verticalBox), child: SvgPicture.asset(R.drawable.svg.iconBoxVertical, colorFilter: _getColor(PageStyle.verticalBox))),
        ],
      );

  ColorFilter? _getColor(PageStyle style) {
    if (style == selectedPageStyle) {
      return ColorFilter.mode(R.themeColor.primary, BlendMode.srcIn);
    }
    return null;
  }
}
