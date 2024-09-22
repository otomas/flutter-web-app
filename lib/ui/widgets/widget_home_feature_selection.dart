import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetInfoFeatureSelection extends StatelessWidget {
  const WidgetInfoFeatureSelection({required this.icon, required this.description, super.key});

  final String icon;
  final String description;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            SvgPicture.asset(icon, width: 60, height: 60),
            const SizedBox(height: 10),
            TextBasic(text: description, fontSize: 14, color: R.themeColor.secondary, fontWeight: FontWeight.bold, maxLines: 1),
          ],
        ),
      );
}
