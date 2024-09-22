import 'package:flutter/material.dart';

import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetVehicleDetailCard extends StatelessWidget {
  const WidgetVehicleDetailCard({
    required this.title,
    this.children,
    this.child,
    super.key,
  });

  final String title;
  final List<Widget>? children;
  final Widget? child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: R.themeColor.viewBg,
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              color: R.themeColor.viewText.withOpacity(0.05),
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: R.themeColor.borderLight))),
              child: TextBasic(
                text: title,
                color: R.themeColor.smokeDark,
                fontFamily: R.fonts.displayBold,
                fontSize: 18,
              ),
            ),
            if (child != null)
              Expanded(child: child!)
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  children?.length ?? 0,
                  (i) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(border: i == children!.length - 1 ? null : Border(bottom: BorderSide(color: R.themeColor.borderLight))),
                    child: children![i],
                  ),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      );
}
