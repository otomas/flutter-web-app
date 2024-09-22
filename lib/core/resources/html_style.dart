import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '_r.dart';

class HtmlStyle {
  Map<String, Style> description({double? fontSize, String? fontFamily, int? maxLines, Color? color}) => {
    'body': Style(
      fontSize: FontSize(fontSize ?? (Platform.isAndroid ? 16.0 : 18.0)),
      color: color ?? R.color.black,
      fontFamily: fontFamily ?? R.fonts.displayRegular,
      maxLines: maxLines,
      padding: HtmlPaddings.zero,
      margin: Margins.zero,
    ),
  };
}
