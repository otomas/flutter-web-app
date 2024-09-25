import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/constants/constant_membership_type.dart';
import '../../../core/enums/enum_app.dart';
import '../../../core/extensions/extension_bool.dart';
import '../../../core/extensions/extension_date.dart';
import '../../../core/models/model_district.dart';
import '../../../core/models/model_dropdown.dart';
import '../../../core/models/request/model_request_register.dart';
import '../../../core/models/response/model_response_city.dart';
import '../../../core/models/response/model_response_country.dart';
import '../../../core/resources/_r.dart';
import '../../../core/services/service_api.dart';
import '../../base/base_view_model.dart';

class VmRegister extends ViewModelBase {
  VmRegister(this.serviceApi) {
    selectedMembershipType = constantMemberShipType.types.first;
    unawaited(init());
  }
  final ServiceApi serviceApi;

  bool detectFieldError = false;

  final MaskTextInputFormatter phoneNumberMask = MaskTextInputFormatter(
    mask: '(###) ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final MaskTextInputFormatter companyPhoneNumberMask = MaskTextInputFormatter(
    mask: '(###) ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final MaskTextInputFormatter companyFaxPhoneNumberMask = MaskTextInputFormatter(
    mask: '(###) ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController tcNumberController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController companyCreatedDateController = TextEditingController();

  final TextEditingController taxOfficeController = TextEditingController();
  final TextEditingController taxNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController companyPhoneNumberController = TextEditingController();
  final TextEditingController companyFaxNoController = TextEditingController();
  final TextEditingController companyEmailAddressController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  DateTime? birthDate;

  DateTime? companyCreatedDate;
  ModelCountry? selectedCountry;
  ModelCity? selectedCity;
  ModelDistrict? selectedDistrict;

  final FocusNode titleFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode surnameFocusNode = FocusNode();
  final FocusNode tcNumberFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode taxOfficeFocusNode = FocusNode();
  final FocusNode taxNoFocusNode = FocusNode();
  final FocusNode companyPhoneNumberFocusNode = FocusNode();
  final FocusNode companyFaxNoFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode passwordConfirmFocusNode = FocusNode();
  final FocusNode companyEmailFocusNode = FocusNode();

  ModelDropdown termsAndCondition = ModelDropdown(id: 1, title: R.string.acceptMembershipTermsAndCondition);

  ConstantMemberShipType constantMemberShipType = ConstantMemberShipType.getInstance();
  ModelDropdown? selectedMembershipType;

  bool isCheckedTermsAndCondition = false;
  @override
  Future<void> init() async {}

  void setSelectedMembershipType(ModelDropdown item) {
    selectedMembershipType = item;
    notifyListeners();
  }

  void setSelectedBirthDate(DateTime selectedDate) {
    birthDate = selectedDate;
    birthDateController.text = birthDate!.dayMonthNameAndYear();
    notifyListeners();
  }

  void setSelectedCompanyDate(DateTime selectedDate) {
    companyCreatedDate = selectedDate;
    companyCreatedDateController.text = birthDate!.dayMonthNameAndYear();
    notifyListeners();
  }

  void setSelectedCountry(ModelCountry? country, bool isAutoComplete) {
    if (selectedCountry == country) {
      return;
    }
    selectedCountry = country;
    selectedCity = null;
    selectedDistrict = null;
    notifyListeners();
  }

  void setSelectedCity(ModelCity? city, bool isAutoComplete) {
    if (selectedCity == city) {
      return;
    }
    selectedCity = city;
    selectedDistrict = null;
    notifyListeners();
  }

  void setSelectedDistrict(ModelDistrict? district, bool isAutoComplete) {
    if (selectedDistrict == district) {
      return;
    }
    selectedDistrict = district;
    notifyListeners();
  }

  void setTermsAndConditionState(bool value) {
    isCheckedTermsAndCondition = value;
    notifyListeners();
  }

  Future<bool> register() async {
    detectFieldError = true;
    notifyListeners();
    var status = true;
    if (selectedMembershipType?.id == constantMemberShipType.legalEntity.id && titleController.text.isEmpty) {
      status = false;
    } else if (nameController.text.isEmpty) {
      status = false;
    } else if (surnameController.text.isEmpty) {
      status = false;
    } else if (birthDate == null) {
      status = false;
    } else if (!phoneNumberMask.getUnmaskedText().isValidPhone()) {
      status = false;
    } else if (!emailController.text.isValidEmail()) {
      status = false;
    } else if (selectedMembershipType?.id == constantMemberShipType.legalEntity.id && companyCreatedDate == null) {
      status = false;
    } else if (selectedMembershipType?.id == constantMemberShipType.legalEntity.id && taxOfficeController.text.isEmpty && int.tryParse(taxOfficeController.text) == null) {
      status = false;
    } else if (selectedMembershipType?.id == constantMemberShipType.legalEntity.id && taxNoController.text.isEmpty) {
      status = false;
    } else if (selectedCountry == null) {
      status = false;
    } else if (selectedCity == null) {
      status = false;
    } else if (selectedDistrict == null) {
      status = false;
    } else if (addressController.text.isEmpty) {
      status = false;
    } else if (!passwordController.text.isValidPassword()) {
      status = false;
    } else if (passwordController.text != passwordConfirmController.text) {
      status = false;
    } else if (!isCheckedTermsAndCondition) {
      errorObserver.message = R.string.pleaseAcceptTermsAndCondition;
      return false;
    }
    if (status) {
      errorObserver.message = 'registered';
      status = false;
    } else {
      errorObserver.message = R.string.pleaseCheckAllFields;
    }
    return _register();
  }

  Future<bool> _register() async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    final body = ModelRequestRegister(
      companyTypeId: selectedMembershipType!.id,
      ownerCitizenNo: tcNumberController.text,
      ownerDateOfBirth: birthDate!,
      ownerFirstName: nameController.text,
      ownerLastName: surnameController.text,
      mobileNumber: phoneNumberMask.unmaskText(phoneNumberController.text),
      email: emailController.text,
      neighborhoodId: selectedDistrict!.id,
      address: addressController.text,
      title: selectedMembershipType?.id !=  constantMemberShipType.legalEntity.id ? null : titleController.text,
      dateOfIncorporation: selectedMembershipType?.id !=  constantMemberShipType.legalEntity.id ? null : companyCreatedDate,
      taxOfficeId: selectedMembershipType?.id !=  constantMemberShipType.legalEntity.id ? null : int.tryParse(taxOfficeController.text) ?? 0,
      taxNo: selectedMembershipType?.id !=  constantMemberShipType.legalEntity.id ? null : taxNoController.text,
      phoneNumber: phoneNumberMask.unmaskText(companyPhoneNumberController.text),
      faxNumber: phoneNumberMask.unmaskText(companyFaxNoController.text),
      accountingEmail: companyEmailAddressController.text,
      password: passwordController.text,
      passwordConfirmation: passwordConfirmController.text,
    );
    await serviceApi.client.register(body).then(
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
