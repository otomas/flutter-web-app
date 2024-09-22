import 'package:flutter/cupertino.dart';

import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetInfoContainer extends StatelessWidget {
  const WidgetInfoContainer({required this.title, required this.description, super.key});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      children: [
        TextBasic(text: title, fontSize: 12, color: R.themeColor.secondary,maxLines: 1),
        TextBasic(text: description, fontSize: 24, color: R.themeColor.secondary, fontWeight: FontWeight.bold,maxLines: 1),
      ],
    ),
  );
}
