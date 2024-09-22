import 'dart:async';

import 'package:flutter/material.dart';

import '/core/enums/enum_app.dart';
import '/core/extensions/extension_bool.dart';
import '/core/services/service_api.dart';
import '/core/utils/general_data.dart';
import '../../../core/services/router/router.gr.dart';
import '../../../core/services/service_route.dart';
import '../../../core/settings/controller_language.dart';
import '../../../core/utils/flavor_config.dart';
import '../../base/base_view_model.dart';

class VmLogin extends ViewModelBase {
  VmLogin(this.serviceApi, this.serviceRoute) {
    unawaited(init());
  }
  final ServiceApi serviceApi;
  final ServiceRoute serviceRoute;

  final TextEditingController usernameController = TextEditingController(text: FlavorConfig.instance.flavorName == Flavor.dev.value ? 'api-user@otomas.com' : null);
  final TextEditingController passwordController = TextEditingController(text: FlavorConfig.instance.flavorName == Flavor.dev.value ? 'password' : null);
  final TextEditingController taxNumberController = TextEditingController(text: FlavorConfig.instance.flavorName == Flavor.dev.value ? '3996604040' : null);

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode taxNumberFocusNode = FocusNode();

  bool detectFieldError = false;

  @override
  Future<void> init() async {
    unawaited(LanguageController.setLanguage(AppLanguage.tr));
    unawaited(GeneralData.getInstance().setAuthState(AuthState.unauthenticated));
    if (GeneralData.getInstance().getRememberMe()) {
      usernameController.text = GeneralData.getInstance().getUsername() ?? '';
      passwordController.text = GeneralData.getInstance().getPassword() ?? '';
      taxNumberController.text = GeneralData.getInstance().getTaxNumber() ?? '';
      if (await login()) {
        unawaited(serviceRoute.startNewView(route: RouteHome(), clearStack: true, isReplace: true));
      }
    }
  }

  Future<bool> login() async {
    detectFieldError = true;
    notifyListeners();
    if (usernameController.text.isEmpty) {
      return false;
    }
    if (passwordController.text.isEmpty) {
      return false;
    }
    if (!taxNumberController.text.isValidTaxNumber()) {
      return false;
    }
    return _login(usernameController.text, passwordController.text, taxNumberController.text);
  }

  Future<bool> _login(String username, String password, String taxNumber) async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.login(username: username, password: password, taxNumber: taxNumber).then(
      (response) {
        state = true;
        GeneralData.getInstance().setTokenData(response.data);
        GeneralData.getInstance().setAuthToken(response.data?.accessToken);
        GeneralData.getInstance().setAuthState(AuthState.authenticated);
        GeneralData.getInstance().setUsername(username);
        GeneralData.getInstance().setPassword(password);
        GeneralData.getInstance().setTaxNumber(taxNumber);
        GeneralData.getInstance().setRememberMe(true);
        serviceApi
          ..setAuthToken(response.data?.accessToken)
          ..setTaxNumber(taxNumber);
        state = true;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
    return state;
  }
}
