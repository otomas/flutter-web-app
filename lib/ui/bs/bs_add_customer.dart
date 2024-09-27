import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/constant_membership_type.dart';
import '../../core/constants/formatter.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_bool.dart';
import '../../core/extensions/extension_date.dart';
import '../../core/extensions/extension_string.dart';
import '../../core/models/model_customer.dart';
import '../../core/models/model_district.dart';
import '../../core/models/model_dropdown.dart';
import '../../core/models/model_neighborhood.dart';
import '../../core/models/response/model_response_city.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_firebase.dart';
import '../../core/utils/alert_utils.dart';
import '../../core/utils/general_data.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import '../widgets/widget_button.dart';
import '../widgets/widget_checkbox.dart';
import '../widgets/widget_dropdown.dart';
import '../widgets/widget_scroll.dart';
import '../widgets/widget_textfield.dart';
import '../widgets/widgets_text.dart';

class BsAddCustomer extends StatefulWidget {
  const BsAddCustomer({super.key, this.id, this.data, this.onAddedCustomer});

  final int? id;
  final ModelCustomer? data;

  final Function()? onAddedCustomer;

  @override
  State<BsAddCustomer> createState() => _BsAddCustomerState();
}

class _BsAddCustomerState extends WidgetBaseStatefull<BsAddCustomer, VmBsAddCustomer> {
  @override
  VmBsAddCustomer createViewModel(BuildContext context) => VmBsAddCustomer(apiService(context), firebaseService(context), widget.id, widget.data);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsAddCustomer viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsAddCustomer viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsAddCustomer viewModel) => ScrollWithNoGlowWidget(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getHeader(context, viewModel),
              const SizedBox(height: 15),
              _getMembershipTypes(context, viewModel),
              const SizedBox(height: 15),
              if (viewModel.selectedMembershipType?.id == viewModel.constantMemberShipType.legalEntity.id)
                _getTextViewBasic(
                  context,
                  viewModel,
                  viewModel.titleController,
                  R.string.title,
                  viewModel.getErrorMsg('title') ?? '',
                  viewModel.isDetectError && viewModel.checkErrorByField('title'),
                ),
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
                        viewModel.getErrorMsg('mobile_number') ?? '',
                        viewModel.isDetectError && viewModel.checkErrorByField('mobile_number'),
                        inputFormatter: phoneNumberMask,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Expanded(
                      child: _getTextViewBasic(
                        context,
                        viewModel,
                        viewModel.emailController,
                        R.string.emailAddress,
                        viewModel.getErrorMsg('email') ?? '',
                        viewModel.isDetectError && viewModel.checkErrorByField('email'),
                        keyboardType: TextInputType.emailAddress,
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
                        viewModel.citizenNoController,
                        R.string.tcNumber,
                        viewModel.getErrorMsg('citizen_no') ?? '',
                        viewModel.isDetectError && viewModel.checkErrorByField('citizen_no'),
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Expanded(child: _getBirthDatePicker(context, viewModel)),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _getCityDropdown(context, viewModel),
              const SizedBox(height: 15),
              _getDistrictDropdown(context, viewModel),
              const SizedBox(height: 15),
              _getNeighborhoodDropdown(context, viewModel),
              const SizedBox(height: 15),
              _getTextViewBasic(context, viewModel, viewModel.addressController, R.string.address, viewModel.getErrorMsg('address') ?? '', viewModel.isDetectError && viewModel.checkErrorByField('address')),
              const SizedBox(height: 15),
              _getTextViewBasic(context, viewModel, viewModel.taxNoController, R.string.taxNo, viewModel.getErrorMsg('tax_number') ?? '', viewModel.isDetectError && viewModel.checkErrorByField('tax_number')),
              const SizedBox(height: 15),
              _getButtons(context, viewModel),
            ],
          ),
        ),
      );

  Widget _getHeader(BuildContext context, VmBsAddCustomer viewModel) => Column(
        children: [
          const SizedBox(height: 10),
          TextBasic(
            text: viewModel.data == null ? R.string.addNewCustomer : R.string.updateUser,
            fontSize: 18,
            fontFamily: R.fonts.displayMedium,
            color: R.themeColor.secondary,
          ),
        ],
      );

  Widget _getMembershipTypes(BuildContext context, VmBsAddCustomer viewModel) => ScrollWithNoGlowWidget(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(viewModel.constantMemberShipType.types.length, (index) {
            final item = viewModel.constantMemberShipType.types[index];
            return Container(
              margin: const EdgeInsets.only(right: 20),
              child: CheckboxBasic(
                key: UniqueKey(),
                item: viewModel.constantMemberShipType.types[index],
                value: viewModel.selectedMembershipType == item,
                onChanged: (v) => viewModel.setSelectedMembershipType(item),
                isRadioButton: true,
                isInnerScroll: true,
              ),
            );
          }),
        ),
      );

  Widget _getCityDropdown(BuildContext context, VmBsAddCustomer viewModel) => DropdownBasic(
        title: R.string.citySelection,
        selectedItem: viewModel.selectedCity,
        // ignore: discarded_futures
        callback: () => apiService(context).client.getCitiesList(),
        hasError: viewModel.isDetectError && viewModel.checkErrorByField('city'),
        errorLabel: R.string.pleaseSelect,
        isRequired: true,
        onChanged: viewModel.setSelectedCity,
      );

  Widget _getDistrictDropdown(BuildContext context, VmBsAddCustomer viewModel) => DropdownBasic(
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

  Widget _getNeighborhoodDropdown(BuildContext context, VmBsAddCustomer viewModel) => DropdownBasic(
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

  Widget _getTextViewBasic(BuildContext context, VmBsAddCustomer viewModel, TextEditingController controller, String labelText, String errorLabel, bool hasError, {TextInputFormatter? inputFormatter, int? maxLength, TextInputType? keyboardType}) =>
      TextFieldBasic(
        controller: controller,
        hintText: labelText,
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

  Widget _getBirthDatePicker(BuildContext context, VmBsAddCustomer viewModel) => GestureDetector(
        onTap: () => showBirthDateSelection(context, viewModel),
        child: TextFieldBasic(
          enabled: false,
          controller: viewModel.birthDateController,
          title: R.string.birthDate,
          isRequired: true,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('date_of_birth'),
          errorLabel: R.string.invalidDate,
          suffixIcon: Icon(Icons.calendar_today_outlined, color: R.themeColor.primary),
        ),
      );

  void showBirthDateSelection(BuildContext context, VmBsAddCustomer viewModel) {
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

  Widget _getButtons(BuildContext context, VmBsAddCustomer viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: ButtonBasic(
              text: R.string.cancel,
              onPressed: () => Navigator.pop(context),
              bgColor: R.themeColor.borderLight,
              textColor: R.themeColor.secondary,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 4,
            child: ButtonBasic(
              text: widget.data == null ? R.string.add : R.string.update,
              onPressed: () async {
                if (widget.id == null) {
                  if (await viewModel.addCustomer()) {
                    if (context.mounted) {
                      unawaited(router(context).onBackPressed());
                      widget.onAddedCustomer?.call();
                    }
                  }
                } else {
                  if (await viewModel.updateCustomer()) {
                    if (context.mounted) {
                      unawaited(router(context).onBackPressed());
                      widget.onAddedCustomer?.call();
                    }
                  }
                }
              },
              bgColor: widget.data == null ? R.themeColor.successLight : R.themeColor.primaryLight,
              textColor: widget.data == null ? R.themeColor.success : R.themeColor.primary,
            ),
          ),
        ],
      );
}

class VmBsAddCustomer extends ViewModelBase {
  VmBsAddCustomer(this.serviceApi, this.serviceFirebase, this.id, this.data) {
    init();
  }

  final ServiceApi serviceApi;
  final ServiceFirebase serviceFirebase;
  final int? id;

  ConstantMemberShipType constantMemberShipType = ConstantMemberShipType.getInstance();
  ModelDropdown? selectedMembershipType = ConstantMemberShipType.getInstance().realEntity;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController citizenNoController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController taxNoController = TextEditingController();

  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController taxOfficeIdController = TextEditingController();

  ModelCity? selectedCity;
  ModelDistrict? selectedDistrict;
  ModelNeighborhood? selectedNeighborhood;
  String? selectedTaxOffice;
  DateTime? birthDate;

  final ModelCustomer? data;

  @override
  void init() {
    if (id != null) {
      if (data?.companyTypeId != null) {
        selectedMembershipType = constantMemberShipType.getMembershipTypeForId(data!.companyTypeId!);
      }
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
      mobileNoController.text = data?.mobileNumber ?? '-';
      addressController.text = data?.address ?? '-';
      titleController.text = data?.title ?? '-';
      citizenNoController.text = data?.citizenNo ?? '-';
      birthDate = data?.dateOfBirth;
      taxNoController.text = data?.taxNo ?? '-';
      if (birthDate != null) {
        setSelectedBirthDate(birthDate!);
      }
    }
  }

  void setSelectedMembershipType(ModelDropdown item) {
    selectedMembershipType = item;
    notifyListeners();
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

  Future<bool> addCustomer() async {
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
      errorFields.addAll({'mobile_number': R.string.invalidPhone});
    }
    if (addressController.text.isNullOrEmpty()) {
      errorFields.addAll({'address': R.string.invalidAddress});
    }
    if (birthDateController.text.isNullOrEmpty()) {
      errorFields.addAll({'date_of_birth': R.string.invalidDate});
    }
    if (selectedCity?.name == null || selectedCity!.name.isNullOrEmpty()) {
      errorFields.addAll({'city': R.string.invalidValue});
    }
    if (selectedDistrict?.name == null || selectedDistrict!.name.isNullOrEmpty()) {
      errorFields.addAll({'district': R.string.invalidValue});
    }
    if (selectedDistrict?.name == null || selectedNeighborhood!.name.isNullOrEmpty()) {
      errorFields.addAll({'neighborhood_id': R.string.invalidValue});
    }
    if (!citizenNoController.text.isValidTCIdentityNumber()) {
      errorFields.addAll({'citizen_no': R.string.invalidTcNo});
    }
    if (selectedMembershipType?.id == constantMemberShipType.legalEntity.id && titleController.text.isEmpty) {
      errorFields.addAll({'title': R.string.invalidTitle});
    }
    if (taxNoController.text.isNullOrEmpty()) {
      errorFields.addAll({'tax_number': R.string.invalidTaxNo});
    }
    notifyListeners();
    if (errorFields.isNotEmpty) {
      return false;
    }
    return _addCustomer(
      selectedMembershipType!.id,
      emailController.text,
      selectedNeighborhood?.id ?? 0,
      nameController.text,
      surnameController.text,
      birthDate.yearMonthDay(),
      citizenNoController.text,
      phoneNumberMask.unmaskText(mobileNoController.text),
      addressController.text,
      titleController.text,
    );
  }

  Future<bool> _addCustomer(int companyTypeId, String email, int neighborhoodId, String firstName, String lastName, String dateOfBirth, String citizenNo, String mobileNumber, String address, String title) async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client
        .addCustomer(
      companyTypeId: companyTypeId,
      title: title,
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

  Future<bool> updateCustomer() async {
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
      errorFields.addAll({'mobile_number': R.string.invalidPhone});
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
    if (!citizenNoController.text.isValidTCIdentityNumber()) {
      errorFields.addAll({'citizen_no': R.string.invalidTcNo});
    }
    if (selectedMembershipType?.id == constantMemberShipType.legalEntity.id && titleController.text.isEmpty) {
      errorFields.addAll({'title': R.string.invalidTitle});
    }
    if (taxNoController.text.isNullOrEmpty()) {
      errorFields.addAll({'tax_number': R.string.invalidTaxNo});
    }
    return _updateCustomer(
      selectedMembershipType!.id,
      emailController.text,
      selectedNeighborhood?.id ?? 0,
      nameController.text,
      surnameController.text,
      birthDate.yearMonthDay(),
      citizenNoController.text,
      mobileNoController.text,
      addressController.text,
      titleController.text,
    );
  }

  Future<bool> _updateCustomer(int companyTypeId, String email, int neighborhoodId, String firstName, String lastName, String dateOfBirth, String citizenNo, String mobileNumber, String address, String title) async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client
        .updateCustomer(
      data?.id ?? 0,
      companyTypeId: companyTypeId,
      title: title,
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
