import 'package:auto_route/auto_route.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../enums/enum_app.dart';
import '../models/response/model_response_login.dart';
import 'utilities.dart';

class GeneralData {
  static GeneralData? _instance;
  static GeneralData getInstance() => _instance ??= GeneralData();

  final String _spDARKMODE = 'dark_mode';
  final String _spLANGUAGE = 'language';
  final String _spDEVICEID = 'device_id';
  final String _spAUTHSTATE = 'auth_state';
  final String _spAUTHTOKEN = 'auth_token';
  final String _spFCMTOKEN = 'fcm_token';
  final String _spTOKENDATA = 'token_data';
  final String _spISCHANGEDFCMTOKEN = 'is_changed_fcm_token';
  final String _spISREGISTEREDDEVICE = 'is_registered_device';
  final String _spREMEMBERME = 'remember_me';
  final String _spUSERNAME = 'username';
  final String _spPASSWORD = 'password';
  final String _spTAXNUMBER = 'tax_number';

  Box<dynamic>? hive;
  String? notificationLink;

  PageRouteInfo<dynamic>? lastRoute;

  DateTime serverTime = DateTime.now().toLocal();

  int takeCount = 10;

  ThemeApperance getDarkMode() => ThemeApperance.values[getUserSp(_spDARKMODE, defaultValue: ThemeApperance.dark.index)];
  Future<void> setDarkMode(ThemeApperance value) async => setUserSp(_spDARKMODE, value.index);

  AppLanguage getLanguage() => AppLanguage.fromId(getUserSp(_spLANGUAGE, defaultValue: AppLanguage.locale.id));
  Future<void> setLanguage(AppLanguage value) async => setUserSp(_spLANGUAGE, value.id);

  Future<String> getDeviceId() async {
    String? deviceId = await getUserSp(_spDEVICEID);
    deviceId ??= const Uuid().v1();
    await setDeviceId(deviceId);
    return deviceId;
  }

  Future<void> setDeviceId(String value) async => setUserSp(_spDEVICEID, value);

  AuthState getAuthState() => AuthState.fromId(getUserSp(_spAUTHSTATE, defaultValue: AuthState.unauthenticated.id));
  Future<void> setAuthState(AuthState value) async => setUserSp(_spAUTHSTATE, value.id);

  String? getFCMToken() => getUserSp(_spFCMTOKEN);
  Future<void> setFCMToken(String value) async => setUserSp(_spFCMTOKEN, value);

  ModelToken? getTokenData() {
    final json = getUserSp(_spTOKENDATA);
    if (json == null) {
      return null;
    } else {
      return JsonMapper.deserialize<ModelToken>(json);
    }
  }

  Future<void> setTokenData(ModelToken? value) async => setUserSp(_spTOKENDATA, JsonMapper.serialize(value));

  bool getDeviceIsRegistered() => getUserSp(_spISREGISTEREDDEVICE, defaultValue: false);
  Future<void> setDeviceIsRegistered(bool value) async => setUserSp(_spISREGISTEREDDEVICE, value);

  bool getIsChangedFCMToken() => getUserSp(_spISCHANGEDFCMTOKEN, defaultValue: true);
  Future<void> setIsChangedFCMToken(bool value) async => setUserSp(_spISCHANGEDFCMTOKEN, value);

  bool getRememberMe() => getUserSp(_spREMEMBERME, defaultValue: false);
  Future<void> setRememberMe(bool value) async => setUserSp(_spREMEMBERME, value);

  String? getAuthToken() => getUserSp(_spAUTHTOKEN);
  Future<void> setAuthToken(String? value) async => setUserSp(_spAUTHTOKEN, value);

  String? getUsername() => getUserSp(_spUSERNAME);
  Future<void> setUsername(String? value) async => setUserSp(_spUSERNAME, value);

  String? getPassword() => getUserSp(_spPASSWORD);
  Future<void> setPassword(String? value) async => setUserSp(_spPASSWORD, value);

  String? getTaxNumber() => getUserSp(_spTAXNUMBER);
  Future<void> setTaxNumber(String? value) async => setUserSp(_spTAXNUMBER, value);
}
