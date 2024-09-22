import 'package:flutter/material.dart';

import 'widget_web_header.dart';

class WidgetWebBase extends StatelessWidget {
  const WidgetWebBase({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const WidgetWebHeader(),
          Expanded(child: child),
          // const WidgetWebFooter(),
        ],
      );
}
