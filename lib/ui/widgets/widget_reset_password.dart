import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/resources/_r.dart';
import 'widget_button.dart';
import 'widget_textfield.dart';
import 'widgets_text.dart';

class WidgetResetPassoword extends StatefulWidget {
  const WidgetResetPassoword({
    required this.title,
    required this.subTitle,
    this.isActiveDivider = true,
    super.key,
  });
  final String title;
  final String subTitle;
  final bool isActiveDivider;

  @override
  State<WidgetResetPassoword> createState() => _WidgetResetPassowordState();
}

class _WidgetResetPassowordState extends State<WidgetResetPassoword> {
  bool isExpanded = false;

  Widget _getResetPasswordWidget(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 5, right: 20, left: 20),
        decoration: BoxDecoration(
          color: R.themeColor.boxBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFieldBasic(
              title: R.string.currentPassword,
              isPassword: true,
              textColor: R.themeColor.primary,
              hintText: R.string.hintCurrentPassword,
            ),
            const SizedBox(height: 10),
            TextFieldBasic(
              title: R.string.newPassword,
              textColor: R.themeColor.primary,
              isPassword: true,
              hintText: R.string.hintNewPassword,
            ),
            Row(
              children: [
                Icon(
                  Icons.info,
                  size: 12,
                  color: R.themeColor.smoke,
                ),
                const SizedBox(width: 5),
                TextBasic(
                  textAlign: TextAlign.center,
                  text: R.string.securityText,
                  fontSize: 10,
                  color: R.themeColor.smoke,
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: ButtonBasic(
                text: R.string.changePassword,
                bgColor: R.themeColor.successLight,
                textColor: R.themeColor.success,
                radius: 12,
              ),
            ),
          ],
        ),
      );

  void setExpandState() {
    isExpanded = !isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(border: !widget.isActiveDivider ? null : Border(bottom: BorderSide(color: R.themeColor.boxBg))),
        margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBasic(
                          text: widget.title,
                          color: R.themeColor.secondary,
                        ),
                        const SizedBox(width: 20),
                        TextBasic(
                          text: widget.subTitle,
                          fontSize: 12,
                          color: R.themeColor.smoke,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: setExpandState,
                  child: Icon(
                    isExpanded ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus,
                    color: R.themeColor.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: !isExpanded ? Container() : _getResetPasswordWidget(context)),
            const SizedBox(height: 20),
          ],
        ),
      );
}
