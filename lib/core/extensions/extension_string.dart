import 'dart:developer';

import 'package:flutter/material.dart';

import '../../ui/widgets/widgets_text.dart';
import '../resources/_r.dart';
import '../settings/controller_language.dart';

extension ExtensionString on String {
  String firstCharacterUppercase() {
    final value = this;
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }

  String firstCharactersUppercase() {
    final value = this;
    final words = value.split(' ');
    var newString = '';
    for (var i = 0; i < words.length; i++) {
      newString += '${i == 0 ? '' : ' '}${words[i][0].toUpperCase()}${words[i].substring(1)}';
    }
    return newString;
  }

  String replaceTurkish() {
    final value = this;
    final str = value
        .replaceAll('İ', 'i')
        .replaceAll('Ö', 'o')
        .replaceAll('Ü', 'u')
        .replaceAll('Ş', 's')
        .replaceAll('Ç', 'c')
        .replaceAll('Ğ', 'g')
        .replaceAll('ı', 'i')
        .replaceAll('ö', 'o')
        .replaceAll('ü', 'u')
        .replaceAll('ş', 's')
        .replaceAll('ç', 'c')
        .replaceAll('ğ', 'g')
        .replaceAll('I', 'i')
        .replaceAll(' ', '');
    return str;
  }

  String tr({Map<String, dynamic>? namedArgs}) {
    final key = this;
    String? text = LanguageController.selectedLocaleJson[key];
    if (text == null) {
      log('[$key] key not found from ${LanguageController.currentLocale.toLanguageTag()}', name: 'LOCALIZATION');
      text = key;
    } else {
      if (namedArgs != null) {
        final keys = namedArgs.keys;
        for (final item in keys) {
          text = text!.replaceFirst('{$item}', namedArgs[item]);
        }
      }
    }

    return text!;
  }

  List<TextSpan> highlightOccurrences(
    String query, {
    required Color textColor,
    Color? boldTextColor,
    double? fontSize,
    double? boldFontSize,
    FontWeight? fontWeight,
    String? font,
    String? boldFont,
    bool isOnlyFirst = false,
  }) {
    final source = this;
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [textSpanBasic(text: source, color: textColor, fontSize: fontSize ?? 14.0, fontWeight: fontWeight)];
    }
    var matches = query.toLowerCase().allMatches(source.toLowerCase());
    if (isOnlyFirst) {
      matches = [matches.elementAt(0)];
    }

    var lastMatchEnd = 0;

    final children = <TextSpan>[];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(
          textSpanBasic(
            text: source.substring(lastMatchEnd, match.start),
            color: textColor,
            fontFamily: font,
            fontSize: fontSize ?? 14.0,
            fontWeight: fontWeight,
          ),
        );
      }

      children.add(
        textSpanBasic(
          text: source.substring(match.start, match.end),
          fontFamily: boldFont ?? font ?? R.fonts.displayBold,
          color: boldTextColor ?? textColor,
          fontSize: boldFontSize ?? 14.0,
          fontWeight: fontWeight,
        ),
      );

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(
          textSpanBasic(
            text: source.substring(match.end, source.length),
            color: textColor,
            fontFamily: font,
            fontSize: fontSize ?? 14.0,
            fontWeight: fontWeight,
          ),
        );
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

  bool hasUpperCase() => RegExp(r'[A-Z]').hasMatch(this);
  bool hasLowerCase() => RegExp(r'[a-z]').hasMatch(this);
  bool hasDigit() => RegExp(r'[0-9]').hasMatch(this);
  bool hasSpecialCharacters() => RegExp(r"[!@#\$%\^&\*(),.?':{}|<>]").hasMatch(this);
  bool isValidLength() => length >= 8;

  Color parseStringToColor() => Color(int.parse('0xFF${replaceAll('#', '')}'));

  String emailToUserName() {
    final emailPrefix = split('@').first;
    if (!emailPrefix.contains('.')) {
      return emailPrefix;
    }
    final userName = emailPrefix.split('.');
    return '${userName.first.capitalize()} ${userName.last.capitalize()}';
  }

  String getEnterpriseName() => split('@').first;

  String capitalize() => '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  String parseHtmlString() => replaceAll('<br/>', '\n');
}

extension ExtensionNullableString on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty || this == '-' || this == ''  || this == ' ';
  bool isNotNullOrEmpty() => !isNullOrEmpty();
}

String formatString(String first, String second) {
  final bWords = second.split(' ');
  final firstWord = bWords.isNotEmpty ? bWords.first : '';
  final remainingWords = bWords.skip(1).join(' ');

  return '$first*$firstWord\n $remainingWords';
}

String parseAndCleanString(String input) {
  final cleanedString = input.replaceAll(RegExp('[^0-9]'), '');
  return cleanedString;
}

bool isPrice(String source) => int.tryParse(source) != null || double.tryParse(source) != null;
