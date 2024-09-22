import 'package:flutter/material.dart';

import '../enums/enum_app.dart';
import '../settings/controller_theme.dart';
import '_r.dart';

//*
// 100 - primary color
// 200 - hover color
// 300 - light color
// 400 - extra color
//*/

const _appColor = Color(0xFF384AD2);

class AppColor {
  final Color transparent = const Color(0x00000000);
  final Color white = const Color(0xFFFFFFFF);
  final Color black = const Color(0xFF000000);

  final Color alabaster = const Color(0xFFF9F9F9);

  final MaterialColor primarySwatch = MaterialColor(_appColor.value, const {
    50: _appColor,
    100: _appColor,
    200: _appColor,
    300: _appColor,
    400: _appColor,
    500: _appColor,
    600: _appColor,
    700: _appColor,
    800: _appColor,
    900: _appColor,
  });

  final MaterialColor blue = MaterialColor(_appColor.value, const {
    100: Color(0xFF384AD2),
    200: Color(0xFF8C9EFF),
    300: Color(0xFFEEF5FC),
  });

  final MaterialColor brightTurquoise = const MaterialColor(0xFF0DCAF0, {
    100: Color(0xFF0DCAF0),
    200: Color(0xFF73E8FF),
    300: Color(0xFFE7FAFD),
  });

  final MaterialColor river = const MaterialColor(0xFF52AB60, {
    100: Color(0xFF52AB60),
    200: Color(0xFF7DD28A),
    300: Color(0xFFEAFAEB),
  });

  final MaterialColor orange = const MaterialColor(0xFFFC6B02, {
    100: Color(0xFFFC6B02),
    200: Color(0xFFFC9802),
    300: Color(0xFFFFF5E6),
  });

  final MaterialColor yellow = const MaterialColor(0xFFFFD700, {
    100: Color(0xFFFFD700),
    200: Color(0xFFFFE975),
    300: Color(0xFFFFF7CB),
  });

  final MaterialColor candy = const MaterialColor(0xFFEA3959, {
    100: Color(0xFFEA3959),
    200: Color(0xFFFF758D),
    300: Color(0xFFFBEBEB),
  });

  final MaterialColor steelGray = const MaterialColor(0xFF26223C, {
    100: Color(0xFF26223C),
    200: Color(0xFF575177),
    300: Color(0xFFEDEBF5),
  });

  final MaterialColor gray = const MaterialColor(0xFF8F8FA7, {
    100: Color(0xFF8F8FA7),
    200: Color(0xFFB0B0B0),
    300: Color(0xFFF1F1F1),
    400: Color(0xFFE2E2E2), //border
    500: Color(0xFF3B3850),
  });

  final Color brown = const Color(0xFF863E16);
  final Color midnight = const Color(0xFF2F3845);

}

class AppThemeColor {
  final Color viewBg = _ThemeColor(dark: R.color.white, light: R.color.white).theme;
  final Color viewText = _ThemeColor(dark: R.color.black, light: R.color.black).theme;

  final Color primary = _ThemeColor(dark: R.color.blue[100]!, light: R.color.blue[100]!).theme;
  final Color primaryHover = _ThemeColor(dark: R.color.blue[200]!, light: R.color.blue[200]!).theme;
  final Color primaryLight = _ThemeColor(dark: R.color.blue[300]!, light: R.color.blue[300]!).theme;

  final Color secondary = _ThemeColor(dark: R.color.steelGray[100]!, light: R.color.steelGray[100]!).theme;
  final Color secondaryHover = _ThemeColor(dark: R.color.steelGray[200]!, light: R.color.steelGray[200]!).theme;
  final Color secondaryLight = _ThemeColor(dark: R.color.steelGray[300]!, light: R.color.steelGray[300]!).theme;

  final Color info = _ThemeColor(dark: R.color.brightTurquoise[100]!, light: R.color.brightTurquoise[100]!).theme;
  final Color infoHover = _ThemeColor(dark: R.color.brightTurquoise[200]!, light: R.color.brightTurquoise[200]!).theme;
  final Color infoLight = _ThemeColor(dark: R.color.brightTurquoise[300]!, light: R.color.brightTurquoise[300]!).theme;

  final Color warning = _ThemeColor(dark: R.color.orange[100]!, light: R.color.orange[100]!).theme;
  final Color warningHover = _ThemeColor(dark: R.color.orange[200]!, light: R.color.orange[200]!).theme;
  final Color warningLight = _ThemeColor(dark: R.color.orange[300]!, light: R.color.orange[300]!).theme;

  final Color error = _ThemeColor(dark: R.color.candy[100]!, light: R.color.candy[100]!).theme;
  final Color errorHover = _ThemeColor(dark: R.color.candy[200]!, light: R.color.candy[200]!).theme;
  final Color errorLight = _ThemeColor(dark: R.color.candy[300]!, light: R.color.candy[300]!).theme;

  final Color success = _ThemeColor(dark: R.color.river[100]!, light: R.color.river[100]!).theme;
  final Color successHover = _ThemeColor(dark: R.color.river[200]!, light: R.color.river[200]!).theme;
  final Color successLight = _ThemeColor(dark: R.color.river[300]!, light: R.color.river[300]!).theme;

  final Color smoke = _ThemeColor(dark: R.color.gray[100]!, light: R.color.gray[100]!).theme;
  final Color borderDark = _ThemeColor(dark: R.color.gray[200]!, light: R.color.gray[200]!).theme;
  final Color borderLight = _ThemeColor(dark: R.color.gray[300]!, light: R.color.gray[300]!).theme;
  final Color border = _ThemeColor(dark: R.color.gray[400]!, light: R.color.gray[400]!).theme;
  final Color smokeDark = _ThemeColor(dark: R.color.gray[500]!, light: R.color.gray[500]!).theme;

  final Color highlighted = _ThemeColor(dark: R.color.yellow[100]!, light: R.color.yellow[100]!).theme;
  final Color highlightedHover = _ThemeColor(dark: R.color.yellow[200]!, light: R.color.yellow[200]!).theme;
  final Color highlightedLight = _ThemeColor(dark: R.color.yellow[300]!, light: R.color.yellow[300]!).theme;

  final Color text = _ThemeColor(dark: R.color.brown, light: R.color.brown).theme;
  final Color boxBg = _ThemeColor(dark: R.color.alabaster, light: R.color.alabaster).theme;
  final Color midnight = _ThemeColor(dark: R.color.midnight, light: R.color.midnight).theme;
}

class _ThemeColor {
  _ThemeColor({required this.dark, required this.light});
  Color light;
  Color dark;

  Color get theme {
    switch (ThemeController.getInstance().currentAppTheme) {
      case ThemeApperance.light:
        return light;
      case ThemeApperance.dark:
        return dark;
      default:
        return light;
    }
  }
}
