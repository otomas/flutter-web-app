import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/resources/_r.dart';
import '../../core/services/service_route.dart';
import 'widget_button.dart';
import 'widgets_text.dart';

// ignore: avoid_implementing_value_types
class WidgetAppBarBasic extends StatelessWidget implements PreferredSize {
  const WidgetAppBarBasic({
    super.key,
    this.title,
    this.onPressedLeading,
    this.actions,
    this.centerTitle = true,
    this.elevation = .5,
    this.titleWidget,
  });
  final String? title;
  final Function()? onPressedLeading;
  final List<Widget>? actions;
  final bool centerTitle;
  final double elevation;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) => AppBar(
        elevation: elevation,
        backgroundColor: R.color.white,
        centerTitle: centerTitle,
        leading: AppbarBackButton(
          onPressed: () {
            onPressedLeading?.call();
            unawaited(Provider.of<ServiceRoute>(context, listen: false).onBackPressed(true));
          },
        ),
        title: titleWidget ?? (title == null ? null : TextBasic(text: title!, color: R.themeColor.primary, fontFamily: R.fonts.displayBold, fontSize: 16)),
        actions: actions,
      );

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => AppBar().preferredSize;
}
