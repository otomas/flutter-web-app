import 'package:flutter/cupertino.dart';

import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetSettingsSwitch extends StatefulWidget {
  const WidgetSettingsSwitch({
    required this.title,
    super.key,
    this.subtitle,
    this.onPressed,
    this.isActiveDivider = true,
  });
  final String title;
  final String? subtitle;
  final Function? onPressed;
  final bool isActiveDivider;

  @override
  State<WidgetSettingsSwitch> createState() => _WidgetSettingsSwitchState();
}

class _WidgetSettingsSwitchState extends State<WidgetSettingsSwitch> {
  bool _switchValue = false;

  void _onSwitchChanged(bool value) {
    setState(() {
      _switchValue = value;
    });

    if (_switchValue && widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(border: !widget.isActiveDivider ? null : Border(bottom: BorderSide(color: R.themeColor.boxBg))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBasic(
                    text: widget.title,
                    color: R.themeColor.secondary,
                  ),
                  if (widget.subtitle != null)
                    TextBasic(
                      text: widget.subtitle!,
                      color: R.themeColor.smoke,
                      fontSize: 12,
                    ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(width: 10),
            CupertinoSwitch(value: _switchValue, onChanged: _onSwitchChanged),
          ],
        ),
      );
}
