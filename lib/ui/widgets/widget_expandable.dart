import 'package:flutter/material.dart';

class WidgetExpandable extends StatelessWidget {
  const WidgetExpandable({required this.isExpanded, required this.child, this.flex = 1, super.key});

  final bool isExpanded;
  final Widget child;
  final int flex;

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return Expanded(flex: flex, child: child);
    } else {
      return child;
    }
  }
}
