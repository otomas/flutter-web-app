import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/resources/_r.dart';

class TextBasic extends StatelessWidget {
  const TextBasic({
    required this.text,
    super.key,
    this.color,
    this.fontFamily,
    this.fontSize,
    this.lineHeight,
    this.underline = false,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.letterSpacing,
  });
  final String text;
  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final double? lineHeight;
  final bool? underline;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) => DefaultTextStyle(
        style: TextStyle(
          letterSpacing: letterSpacing,
          color: color ?? R.color.black,
          fontFamily: fontFamily ?? R.fonts.displayRegular,
          fontSize: fontSize ?? 14.0,
          decoration: underline! ? TextDecoration.underline : null,
          fontWeight: fontWeight ?? FontWeight.normal,
          height: lineHeight ?? 1.2,
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
          maxLines: maxLines ?? 999,
          textScaler: const TextScaler.linear(1),
        ),
      );
}

TextSpan textSpanBasic({
  String? text,
  Color? color,
  String? fontFamily,
  FontWeight? fontWeight,
  double? fontSize,
  bool? underline = false,
}) =>
    TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily ?? R.fonts.displayRegular,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        decoration: underline! ? TextDecoration.underline : null,
      ),
    );

class RichTextBasic extends StatelessWidget {
  const RichTextBasic({super.key, this.texts, this.textAlign});
  final List<TextSpan>? texts;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => RichText(
        textAlign: textAlign ?? TextAlign.center,
        text: TextSpan(
          children: texts,
        ),
      );
}

class WidgetInfoCardText extends StatelessWidget {
  const WidgetInfoCardText({required this.title, required this.value, super.key, this.valueColor});
  final String title;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: R.themeColor.boxBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextBasic(text: title, color: R.themeColor.secondary, fontSize: 10, fontFamily: R.fonts.displayMedium),
            const SizedBox(height: 5),
            TextBasic(text: value, color: valueColor ?? R.themeColor.secondary, fontSize: 12, fontFamily: R.fonts.displayBold, textAlign: TextAlign.center),
          ],
        ),
      );
}

class WidgetValueText extends StatelessWidget {
  const WidgetValueText({
    required this.title,
    required this.value,
    this.isActiveDivider = true,
    super.key,
    this.valueColor,
  });

  final String title;
  final String value;
  final bool isActiveDivider;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(border: !isActiveDivider ? null : Border(bottom: BorderSide(color: R.themeColor.borderLight))),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: TextBasic(
                text: title,
                color: R.themeColor.secondaryHover,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 16),
            TextBasic(
              text: value,
              color: valueColor ?? R.themeColor.secondaryHover,
              fontFamily: R.fonts.displayBold,
              fontSize: 16,
            ),
          ],
        ),
      );
}

class WidgetLocationText extends StatelessWidget {
  const WidgetLocationText({required this.city, required this.district, super.key});

  final String city;
  final String district;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        SvgPicture.asset(R.drawable.svg.iconLocation),
        const SizedBox(width: 5),
        TextBasic(text: '$city /$district', color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayMedium, fontSize: 14),
      ],
    );
}
