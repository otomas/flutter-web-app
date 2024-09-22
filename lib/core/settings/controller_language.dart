// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

import '../enums/enum_app.dart';
import '../models/model_dropdown.dart';
import '../resources/_r.dart';
import '../utils/general_data.dart';

class LanguageController {
  static AppLanguage currentAppLang = AppLanguage.en;

  static ModelDropdown tr = ModelDropdown(id: AppLanguage.tr.id, title: 'Türkçe', text: 'tr');
  static ModelDropdown en = ModelDropdown(id: AppLanguage.en.id, title: 'English', text: 'en');

  static late Locale currentLocale;
  static DateTimePickerLocale datePickerLocale = DateTimePickerLocale.en_us;
  static late Map<String, dynamic> selectedLocaleJson;

  static const String translationsPath = 'assets/translations';
  static const List<Locale> supportedLocales = [Locale('en', 'US'), Locale('tr', 'TR')];

  static Future<void> setLanguage(AppLanguage language) async {
    if (GeneralData.getInstance().getLanguage() != language) {
      currentAppLang = language;
      await GeneralData.getInstance().setLanguage(language);
      await initialize();
    }
    R.refreshClass();

    log('current language: ${currentLocale.toLanguageTag()}', name: 'LOCALIZATION');
  }

  static Future<void> initialize() async {
    switch (GeneralData.getInstance().getLanguage()) {
      case AppLanguage.en:
        currentLocale = supportedLocales[0];
        currentAppLang = AppLanguage.en;
        datePickerLocale = DateTimePickerLocale.en_us;
        await loadLang();
      case AppLanguage.tr:
        currentLocale = supportedLocales[1];
        currentAppLang = AppLanguage.tr;
        datePickerLocale = DateTimePickerLocale.tr;
        await loadLang();
      default:
        late Locale deviceLocale;
        if (kIsWeb) {
          deviceLocale = Locale(WidgetsBinding.instance.platformDispatcher.locale.languageCode, '');
        } else {
          deviceLocale = Locale(Platform.localeName.substring(0, 2));
        }
        final localeIndex = supportedLocales.indexWhere((element) => element.languageCode == deviceLocale.languageCode);
        if (localeIndex == -1) {
          currentLocale = supportedLocales[0];
          currentAppLang = AppLanguage.en;
          datePickerLocale = DateTimePickerLocale.en_us;
          await loadLang();
          break;
        }
        currentLocale = supportedLocales[localeIndex];
        currentAppLang = AppLanguage.locale;
        await loadLang();
        break;
    }
    final datePickerLangList = DateTimePickerLocale.values.where((element) => element.name.contains(currentLocale.languageCode)).toList();
    if (datePickerLangList.isNotEmpty) {
      datePickerLocale = datePickerLangList.first;
    }

    log('current language: ${currentLocale.toLanguageTag()}', name: 'LOCALIZATION');
  }

  static Future<void> loadLang() async {
    selectedLocaleJson = jsonDecode(await rootBundle.loadString('$translationsPath/${currentLocale.toLanguageTag()}.json'));
  }

  static List<ModelDropdown> getLanguagesForDropdown() => [tr, en];

  static Locale getLocale(String tag) => supportedLocales.firstWhere((element) => element.languageCode.substring(0, 2) == tag);
}
