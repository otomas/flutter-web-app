import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/constants/formatter.dart';
import '/core/enums/enum_app.dart';
import '/core/extensions/extension_bool.dart';
import '/core/extensions/extension_date.dart';
import '/core/extensions/extension_string.dart';
import '/core/models/model_district.dart';
import '/core/models/model_neighborhood.dart';
import '/core/models/model_user_info.dart';
import '/core/models/response/model_response_city.dart';
import '/core/resources/_r.dart';
import '/core/services/service_api.dart';
import '/core/services/service_firebase.dart';
import '/ui/base/base_view.dart';
import '/ui/base/base_view_model.dart';
import '/ui/widgets/widget_button.dart';
import '/ui/widgets/widget_dropdown.dart';
import '/ui/widgets/widget_scroll.dart';
import '/ui/widgets/widget_textfield.dart';
import '/ui/widgets/widgets_text.dart';
import '../../core/utils/alert_utils.dart';
import '../../core/utils/general_data.dart';

class BsAddUser extends StatefulWidget {
  const BsAddUser({super.key, this.id, this.data});
  final int? id;
  final ModelUserInfo? data;

  @override
  State<BsAddUser> createState() => _BsAddUserState();
}

class _BsAddUserState extends WidgetBaseStatefull<BsAddUser, VmBsAddUser> {
  @override
  VmBsAddUser createViewModel(BuildContext context) => VmBsAddUser(apiService(context), firebaseService(context), widget.id, widget.data);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsAddUser viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsAddUser viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsAddUser viewModel) => ScrollWithNoGlowWidget(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getHeader(context, viewModel),
              const SizedBox(height: 15),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _getTextViewBasic(
                        context,
                        viewModel,
                        viewModel.nameController,
                        R.string.name,
                        viewModel.getErrorMsg('first_name') ?? '',
                        viewModel.isDetectError && viewModel.checkErrorByField('first_name'),
                      ),
                    ),
                    Expanded(
                      child: _getTextViewBasic(
                        context,
                        viewModel,
                        viewModel.surnameController,
                        R.string.surname,
                        viewModel.getErrorMsg('last_name') ?? '',
                        viewModel.isDetectError && viewModel.checkErrorByField('last_name'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _getTextViewBasic(
                        context,
                        viewModel,
                        viewModel.mobileNoController,
                        R.string.mobilePhone,
                        viewModel.getErrorMsg('mobile_phone') ?? '',
                        viewModel.isDetectError && viewModel.checkErrorByField('mobile_phone'),
                        keyboardType: TextInputType.number,
                        inputFormatter: phoneNumberMask,
                      ),
                    ),
                    Expanded(
                      child: _getTextViewBasic(
                        context,
                        viewModel,
                        viewModel.tcknController,
                        R.string.tcNumber,
                        viewModel.getErrorMsg('citizen_no') ?? '',
                        viewModel.isDetectError && viewModel.checkErrorByField('citizen_no'),
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _getTextViewBasic(
                context,
                viewModel,
                viewModel.emailController,
                R.string.emailAddress,
                viewModel.getErrorMsg('email') ?? '',
                viewModel.isDetectError && viewModel.checkErrorByField('email'),
              ),
              const SizedBox(height: 15),
              _getCityDropdown(context, viewModel),
              const SizedBox(height: 15),
              _getDistrictDropdown(context, viewModel),
              const SizedBox(height: 15),
              _getNeighborhoodDropdown(context, viewModel),
              const SizedBox(height: 15),
              _getTextViewBasic(
                context,
                viewModel,
                viewModel.addressController,
                R.string.address,
                viewModel.getErrorMsg('address') ?? '',
                viewModel.isDetectError && viewModel.checkErrorByField('address'),
              ),
              const SizedBox(height: 15),
              _getBirthDatePicker(context, viewModel),
              const SizedBox(height: 15),
              _getButtons(context, viewModel),
            ],
          ),
        ),
      );

  Widget _getHeader(BuildContext context, VmBsAddUser viewModel) => Column(
        children: [
          const SizedBox(height: 10),
          TextBasic(
            text: viewModel.data == null ? R.string.addNewUser : R.string.updateUser,
            fontSize: 18,
            fontFamily: R.fonts.displayMedium,
            color: R.themeColor.secondary,
          ),
        ],
      );

  Widget _getTextViewBasic(BuildContext context, VmBsAddUser viewModel, TextEditingController controller, String labelText, String errorLabel, bool hasError, {TextInputFormatter? inputFormatter, int? maxLength, TextInputType? keyboardType}) =>
      TextFieldBasic(
        controller: controller,
        textColor: R.themeColor.primary,
        labelText: labelText,
        errorLabel: errorLabel,
        hasError: hasError,
        title: labelText,
        isRequired: true,
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatter != null ? [inputFormatter] : null,
        onFieldSubmitted: (value) {
          setState(() {});
        },
      );

  Widget _getCityDropdown(BuildContext context, VmBsAddUser viewModel) => DropdownBasic(
        title: R.string.citySelection,
        selectedItem: viewModel.selectedCity,
        // ignore: discarded_futures
        callback: () => apiService(context).client.getCitiesList(),
        hasError: viewModel.isDetectError && viewModel.checkErrorByField('city'),
        errorLabel: R.string.pleaseSelect,
        isRequired: true,
        onChanged: viewModel.setSelectedCity,
      );

  Widget _getDistrictDropdown(BuildContext context, VmBsAddUser viewModel) => DropdownBasic(
        key: ValueKey(viewModel.selectedCity),
        title: R.string.districtSelection,
        selectedItem: viewModel.selectedDistrict,
        // ignore: discarded_futures
        callback: () => apiService(context).client.getDistricts(viewModel.selectedCity!.id),
        hasError: viewModel.isDetectError && viewModel.checkErrorByField('district'),
        errorLabel: R.string.pleaseSelect,
        isRequired: true,
        onChanged: viewModel.setSelectedDistrict,
        customOnTap: viewModel.selectedCity != null
            ? null
            : () {
                viewModel.errorObserver.message = R.string.pleaseSelectCity;
              },
      );

  Widget _getNeighborhoodDropdown(BuildContext context, VmBsAddUser viewModel) => DropdownBasic(
        key: ValueKey(viewModel.selectedDistrict),
        title: R.string.neighbourhoodSelection,
        selectedItem: viewModel.selectedNeighborhood,
        // ignore: discarded_futures
        callback: () => apiService(context).client.getNeighbourhood(viewModel.selectedDistrict!.id),
        hasError: viewModel.isDetectError && viewModel.checkErrorByField('neighborhood_id'),
        errorLabel: R.string.pleaseSelect,
        isRequired: true,
        onChanged: viewModel.setSelectedNeighborhood,
        customOnTap: viewModel.selectedDistrict != null
            ? null
            : () {
                viewModel.errorObserver.message = R.string.pleaseSelectNeighbourhood;
              },
      );

  Widget _getBirthDatePicker(BuildContext context, VmBsAddUser viewModel) => GestureDetector(
        onTap: () => showBirthDateSelection(context, viewModel),
        child: TextFieldBasic(
          enabled: false,
          controller: viewModel.birthDateController,
          title: R.string.birthDate,
          isRequired: true,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('date_of_birth'),
          errorLabel: viewModel.getErrorMsg('date_of_birth'),
          suffixIcon: Icon(Icons.calendar_today_outlined, color: R.themeColor.primary),
        ),
      );

  void showBirthDateSelection(BuildContext context, VmBsAddUser viewModel) {
    unawaited(
      showCustomDatePicker(
        context,
        initial: viewModel.birthDate,
        min: GeneralData.getInstance().serverTime.add(const Duration(days: -(365 * 120))),
        max: GeneralData.getInstance().serverTime.add(const Duration(days: -(365 * 18))),
        onConfirm: (date, _) {
          viewModel.setSelectedBirthDate(date);
        },
      ),
    );
  }

  Widget _getButtons(BuildContext context, VmBsAddUser viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ButtonBasic(
              text: R.string.cancel,
              onPressed: () => Navigator.pop(context),
              bgColor: R.themeColor.borderLight,
              textColor: R.themeColor.secondary,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: SizedBox(
              child: ButtonBasic(
                text: widget.data == null ? R.string.addNewUser : R.string.update,
                onPressed: () async {
                  if (widget.id == null) {
                    if (await viewModel.addUser()) {
                      if (context.mounted) {
                        unawaited(router(context).onBackPressed());
                      }
                    }
                  } else {
                    if (await viewModel.updateUser()) {
                      if (context.mounted) {
                        await router(context).onBackPressed();
                      }
                    }
                  }
                },
                bgColor: widget.data == null ? R.themeColor.successLight : R.themeColor.primaryLight,
                textColor: widget.data == null ? R.themeColor.success : R.themeColor.primary,
              ),
            ),
          ),
        ],
      );
}

class VmBsAddUser extends ViewModelBase {
  VmBsAddUser(this.serviceApi, this.serviceFirebase, this.id, this.data) {
    init();
  }

  final ServiceApi serviceApi;
  final ServiceFirebase serviceFirebase;
  final int? id;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController tcknController = TextEditingController();

  ModelCity? selectedCity;
  ModelDistrict? selectedDistrict;
  ModelNeighborhood? selectedNeighborhood;
  DateTime? birthDate;

  final ModelUserInfo? data;

  @override
  void init() {
    if (id != null) {
      selectedDistrict = ModelDistrict(
        id: data?.neighborhood?.district?.id ?? 0,
        provinceId: data?.neighborhood?.district?.province?.id ?? 0,
        name: data?.neighborhood?.district?.name ?? '-',
      );
      selectedCity = ModelCity(
        id: data?.neighborhood?.district?.province?.id ?? 0,
        regionId: data?.neighborhood?.district?.province?.region?.id ?? 0,
        name: data?.neighborhood?.district?.province?.name ?? '-',
      );
      selectedNeighborhood = ModelNeighborhood(
        id: data?.neighborhood?.id ?? 0,
        districtId: data?.neighborhood?.district?.id ?? 0,
        name: data?.neighborhood?.district?.province?.name ?? '-',
      );
      nameController.text = data?.firstName ?? '-';
      surnameController.text = data?.lastName ?? '-';
      emailController.text = data?.email ?? '-';
      mobileNoController.text = data?.mobileNo ?? '-';
      addressController.text = data?.address ?? '-';
      tcknController.text = data?.citizenNo ?? '-';
      birthDate = data?.dateOfBirth;
      if (birthDate != null) {
        setSelectedBirthDate(birthDate!);
      }
    }
  }

  void setSelectedCity(ModelCity? city, bool isAutoComplete) {
    selectedCity = city;
    if (isAutoComplete) {
      selectedDistrict = null;
      selectedNeighborhood = null;
    }
    notifyListeners();
  }

  void setSelectedDistrict(ModelDistrict? district, bool isAutoComplete) {
    selectedDistrict = district;
    if (isAutoComplete) {
      selectedNeighborhood = null;
    }
    notifyListeners();
  }

  void setSelectedNeighborhood(ModelNeighborhood? neighborhood, bool isAutoComplete) {
    selectedNeighborhood = neighborhood;
  }

  void setSelectedBirthDate(DateTime selectedDate) {
    birthDate = selectedDate;
    birthDateController.text = birthDate!.dayMonthNameAndYear();
    notifyListeners();
  }

  Future<bool> addUser() async {
    isDetectError = true;
    errorFields.clear();
    if (!emailController.text.isValidEmail()) {
      errorFields.addAll({'email': R.string.invalidEmail});
    }
    if (nameController.text.isNullOrEmpty()) {
      errorFields.addAll({'first_name': R.string.invalidName});
    }
    if (surnameController.text.isNullOrEmpty()) {
      errorFields.addAll({'last_name': R.string.invalidSurname});
    }
    if (!phoneNumberMask.unmaskText(mobileNoController.text).isValidPhone()) {
      errorFields.addAll({'mobile_phone': R.string.invalidPhone});
    }
    if (addressController.text.isNullOrEmpty()) {
      errorFields.addAll({'address': R.string.invalidAddress});
    }
    if (birthDateController.text.isNullOrEmpty()) {
      errorFields.addAll({'date_of_birth': R.string.pleaseSelect});
    }
    if (selectedCity?.name == null || selectedCity!.name.isNullOrEmpty()) {
      errorFields.addAll({'city': R.string.pleaseSelect});
    }
    if (selectedDistrict?.name == null || selectedDistrict!.name.isNullOrEmpty()) {
      errorFields.addAll({'district': R.string.pleaseSelect});
    }
    if (selectedNeighborhood?.name == null || selectedNeighborhood!.name.isNullOrEmpty()) {
      errorFields.addAll({'neighborhood_id': R.string.pleaseSelect});
    }
    if (!tcknController.text.isValidTCIdentityNumber()) {
      errorFields.addAll({'citizen_no': R.string.invalidValue});
    }
    notifyListeners();
    if (errorFields.isNotEmpty) {
      return false;
    }
    return _addUser(emailController.text, selectedNeighborhood?.id ?? 0, nameController.text, surnameController.text, birthDate.yearMonthDay(), tcknController.text, mobileNoController.text, addressController.text);
  }

  Future<bool> _addUser(String email, int neighborhoodId, String firstName, String lastName, String dateOfBirth, String citizenNo, String mobileNumber, String address) async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client
        .addUser(
      email: email,
      neighborhoodId: neighborhoodId,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      citizenNo: citizenNo,
      mobileNumber: phoneNumberMask.unmaskText(mobileNumber),
      address: address,
    )
        .then(
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

  Future<bool> updateUser() async {
    isDetectError = true;
    errorFields.clear();
    if (!emailController.text.isValidEmail()) {
      errorFields.addAll({'email': R.string.invalidEmail});
    }
    if (nameController.text.isNullOrEmpty()) {
      errorFields.addAll({'first_name': R.string.invalidName});
    }
    if (surnameController.text.isNullOrEmpty()) {
      errorFields.addAll({'last_name': R.string.invalidSurname});
    }
    if (!phoneNumberMask.unmaskText(mobileNoController.text).isValidPhone()) {
      errorFields.addAll({'mobile_phone': R.string.invalidPhone});
    }
    if (addressController.text.isNullOrEmpty()) {
      errorFields.addAll({'address': R.string.invalidAddress});
    }
    if (birthDateController.text.isNullOrEmpty()) {
      errorFields.addAll({'date_of_birth': R.string.invalidDate});
    }
    if (selectedCity!.name.isNullOrEmpty()) {
      errorFields.addAll({'city': R.string.invalidValue});
    }
    if (selectedDistrict!.name.isNullOrEmpty()) {
      errorFields.addAll({'district': R.string.invalidValue});
    }
    if (selectedNeighborhood!.name.isNullOrEmpty()) {
      errorFields.addAll({'neighborhood_id': R.string.invalidValue});
    }
    if (!tcknController.text.isValidTCIdentityNumber()) {
      errorFields.addAll({'citizen_no': R.string.invalidValue});
    }
    notifyListeners();
    if (errorFields.isNotEmpty) {
      return false;
    }
    return _updateUser(emailController.text, selectedNeighborhood?.id ?? 0, nameController.text, surnameController.text, birthDate.yearMonthDay(), tcknController.text, mobileNoController.text, addressController.text);
  }

  Future<bool> _updateUser(
    String email,
    int neighborhoodId,
    String firstName,
    String lastName,
    String dateOfBirth,
    String citizenNo,
    String mobileNumber,
    String address,
  ) async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client
        .updateUser(
      data?.id ?? 0,
      email: email,
      neighborhoodId: neighborhoodId,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      citizenNo: citizenNo,
      mobileNumber: phoneNumberMask.unmaskText(mobileNumber),
      address: address,
    )
        .then(
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
