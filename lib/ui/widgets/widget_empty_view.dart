import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetEmptyView extends StatelessWidget {
  const WidgetEmptyView({super.key, this.svgPath, this.title, this.isExpanded = true});

  final String? svgPath;
  final String? title;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) => isExpanded ? Expanded(child: _getContent(context)) : _getContent(context);

  Widget _getContent(BuildContext context) => Padding(
    padding: const EdgeInsets.all(40),
    child: Column(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                border: Border.all(color: R.themeColor.border),
                shape: BoxShape.circle,
                color: R.themeColor.boxBg,
              ),
              child: Center(child: SvgPicture.asset(svgPath ?? R.drawable.svg.iconSearch, height: 60, width: 60)),
            ),
            const SizedBox(height: 20),
            TextBasic(text: title ?? 'Kayıt bulunamadı', color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayMedium, fontSize: 18),
          ],
        ),
  );
}
