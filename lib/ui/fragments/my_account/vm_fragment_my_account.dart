import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/enums/enum_app.dart';
import '../../../core/extensions/extension_date.dart';
import '../../../core/models/model_user_profile.dart';
import '../../../core/services/service_api.dart';
import '../../base/base_view_model.dart';

class VmFragmentMyAccount extends ViewModelBase {
  VmFragmentMyAccount(this.serviceApi) {
    init();
  }
  final ServiceApi serviceApi;

  TextEditingController establishmentController = TextEditingController();
  TextEditingController corporationCreatedDateController = TextEditingController();
  TextEditingController corporationEmailController = TextEditingController();
  TextEditingController authorizedNameController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController authorizedEmailController = TextEditingController();
  TextEditingController taxOfficeController = TextEditingController();
  TextEditingController taxNoController = TextEditingController();

  ModelUserProfile? data;

  bool isEditable = false;

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getUserProfile().then(
      (response) {
        data = response.data;
        if (data != null) {
          establishmentController = TextEditingController(text: data!.company?.title);
          corporationCreatedDateController = TextEditingController(text: data!.company?.dateOfIncorporation.dayMonthNameAndYear());
          corporationEmailController = TextEditingController(text: data!.company?.email);
          authorizedNameController = TextEditingController(text: data!.company?.ownerFullName);
          mobilePhoneController = TextEditingController(text: data!.company?.mobileNumber);
          authorizedEmailController = TextEditingController(text: data!.company?.email);
          taxOfficeController = TextEditingController(text: data!.company?.taxOffice);
          taxNoController = TextEditingController(text: data!.company?.taxNumber);
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  void edit() {
    isEditable = !isEditable;
    notifyListeners();
  }

  void saveChanges() {
    edit();
  }
}
