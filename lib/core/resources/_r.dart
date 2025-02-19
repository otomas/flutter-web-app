
// ignore_for_file: avoid_classes_with_only_static_members

import '../resources/color.dart';
import '../resources/dimens.dart';
import '../resources/drawable.dart';
import '../resources/fonts.dart';
import '../resources/strings.dart';
import 'html_style.dart';

class R {
  static void refreshClass() {
    _drawable = null;
    _color = null;
    _themeColor = null;
    _fonts = null;
    _string = null;
    _dimens = null;
  }

  static Drawable? _drawable;
  static Drawable get drawable => _drawable ??= Drawable();

  static AppColor? _color;
  static AppColor get color => _color ??= AppColor();

  static AppThemeColor? _themeColor;
  static AppThemeColor get themeColor => _themeColor ??= AppThemeColor();

  static Fonts? _fonts;
  static Fonts get fonts => _fonts ??= Fonts();

  static AppStrings? _string;
  static AppStrings get string => _string ??= AppStrings();

  static Dimens? _dimens;
  static Dimens get dimens => _dimens ??= Dimens();

  static HtmlStyle? _htmlStyle;
  static HtmlStyle get htmlStyle => _htmlStyle ??= HtmlStyle();
}
