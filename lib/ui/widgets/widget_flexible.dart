import 'package:flutter/material.dart';

class WidgetFlexible extends StatelessWidget {
  const WidgetFlexible({
    required this.isRow,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    super.key,
  });

  final bool isRow;
  final List<Widget> children;

  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (isRow) {
      return Row(crossAxisAlignment: crossAxisAlignment, mainAxisAlignment: mainAxisAlignment, children: children);
    }
    return Column(crossAxisAlignment: crossAxisAlignment, mainAxisAlignment: mainAxisAlignment, children: children);
  }
}
