import 'package:flutter/material.dart';

import '../../../core/enums/enum_app.dart';
import '../../../core/extensions/extension_bool.dart';
import '../../../core/services/service_api.dart';
import '../../base/base_view_model.dart';

class VmForgotPassword extends ViewModelBase {
  VmForgotPassword(this.serviceApi) {
    init();
  }
  final ServiceApi serviceApi;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode taxNumberFocusNode = FocusNode();

  @override
  void init() {}

  Future<bool> resetPassword() async {
    isDetectError = true;
    notifyListeners();
    if (!emailController.text.isValidEmail()) {
      return false;
    }
    if (!taxNumberController.text.isValidTaxNumber()) {
      return false;
    }
    return _resetPassword(emailController.text, taxNumberController.text);
  }

  Future<bool> _resetPassword(String email, String taxNumber) async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.forgotPassword(email: email, taxNo: taxNumber).then(
      (response) {
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
