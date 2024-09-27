import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/formatter.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_bool.dart';
import '../../core/extensions/extension_string.dart';
import '../../core/models/model_branches.dart';
import '../../core/models/model_district.dart';
import '../../core/models/model_neighborhood.dart';
import '../../core/models/response/model_response_city.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_firebase.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import '../widgets/widget_button.dart';
import '../widgets/widget_dropdown.dart';
import '../widgets/widget_scroll.dart';
import '../widgets/widget_textfield.dart';
import '../widgets/widgets_text.dart';

class BsAddBranch extends StatefulWidget {
  const BsAddBranch({required this.onSuccess, super.key, this.id, this.data});
  final int? id;
  final ModelBranch? data;
  final Function() onSuccess;

  @override
  State<BsAddBranch> createState() => _BsAddBranchState();
}

class _BsAddBranchState extends WidgetBaseStatefull<BsAddBranch, VmBsAddBranch> {
  @override
  VmBsAddBranch createViewModel(BuildContext context) => VmBsAddBranch(apiService(context), firebaseService(context), widget.id, widget.data);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsAddBranch viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsAddBranch viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsAddBranch viewModel) => ScrollWithNoGlowWidget(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getHeader(context, viewModel),
              const SizedBox(height: 15),
              _getTextViewBasic(
                context,
                viewModel,
                viewModel.nameController,
                R.string.name,
                viewModel.getErrorMsg('name') ?? '',
                viewModel.isDetectError && viewModel.checkErrorByField('name'),
              ),
              const SizedBox(height: 15),
              _getTextViewBasic(
                context,
                viewModel,
                viewModel.phoneNumberController,
                R.string.mobilePhone,
                viewModel.getErrorMsg('phone_number') ?? '',
                viewModel.isDetectError && viewModel.checkErrorByField('phone_number'),
                inputFormatter: phoneNumberMask,
                keyboardType: TextInputType.phone,
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
              _getButtons(context, viewModel),
            ],
          ),
        ),
      );

  Widget _getHeader(BuildContext context, VmBsAddBranch viewModel) => Column(
        children: [
          const SizedBox(height: 10),
          TextBasic(
            text: viewModel.data == null ? R.string.addNewBranch : R.string.updateBranch,
            // ignore: prefer_int_literals
            fontSize: 18.0,
            fontFamily: R.fonts.displayMedium,
            color: R.themeColor.secondary,
          ),
        ],
      );

  Widget _getTextViewBasic(BuildContext context, VmBsAddBranch viewModel, TextEditingController controller, String labelText, String errorLabel, bool hasError, {TextInputFormatter? inputFormatter, int? maxLength, TextInputType? keyboardType}) =>
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

  Widget _getButtons(BuildContext context, VmBsAddBranch viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ButtonBasic(
              text: R.string.cancel,
              onPressed: () => Navigator.pop(context),
              bgColor: R.themeColor.borderLight,
              textColor: R.themeColor.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ButtonBasic(
              text: widget.data == null ? R.string.add : R.string.update,
              onPressed: () async {
                if (widget.id == null) {
                  if (await viewModel.addBranch()) {
                    if (context.mounted) {
                      unawaited(router(context).startNewViewWithPath(route: '/home/branches'));
                      widget.onSuccess();
                    }
                  }
                } else {
                  if (await viewModel.updateBranch()) {
                    if (context.mounted) {
                      unawaited(router(context).startNewViewWithPath(route: '/home/branches'));
                      widget.onSuccess();
                    }
                  }
                }
              },
              bgColor: widget.data == null ? R.themeColor.successLight : R.themeColor.primaryLight,
              textColor: widget.data == null ? R.color.river : R.themeColor.primary,
            ),
          ),
        ],
      );

  Widget _getCityDropdown(BuildContext context, VmBsAddBranch viewModel) => DropdownBasic(
        title: R.string.citySelection,
        selectedItem: viewModel.selectedCity,
        // ignore: discarded_futures
        callback: () => apiService(context).client.getCitiesList(),
        hasError: viewModel.isDetectError && viewModel.checkErrorByField('city'),
        errorLabel: R.string.pleaseSelect,
        isRequired: true,
        onChanged: viewModel.setSelectedCity,
      );

  Widget _getDistrictDropdown(BuildContext context, VmBsAddBranch viewModel) => DropdownBasic(
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

  Widget _getNeighborhoodDropdown(BuildContext context, VmBsAddBranch viewModel) => DropdownBasic(
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
}

class VmBsAddBranch extends ViewModelBase {
  VmBsAddBranch(this.serviceApi, this.serviceFirebase, this.id, this.data) {
    init();
  }

  final ServiceApi serviceApi;
  final ServiceFirebase serviceFirebase;
  final int? id;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  ModelCity? selectedCity;
  ModelDistrict? selectedDistrict;
  ModelNeighborhood? selectedNeighborhood;

  final ModelBranch? data;

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
      nameController.text = data?.name ?? '-';
      phoneNumberController.text = phoneNumberMask.maskText(data?.phone ?? '-');
      addressController.text = data?.address ?? '-';
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

  Future<bool> addBranch() async {
    isDetectError = true;
    errorFields.clear();
    if (nameController.text.isEmpty) {
      errorFields.addAll({'name': R.string.invalidName});
    }
    if (!phoneNumberMask.unmaskText(phoneNumberController.text).isValidPhone()) {
      errorFields.addAll({'phone_number': R.string.invalidPhone});
    }
    if (addressController.text.isNullOrEmpty()) {
      errorFields.addAll({'address': R.string.invalidAddress});
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
    notifyListeners();
    if (errorFields.isNotEmpty) {
      return false;
    }
    return _addBranch(nameController.text, selectedNeighborhood?.id ?? 0, phoneNumberMask.unmaskText(phoneNumberController.text), addressController.text);
  }

  Future<bool> _addBranch(String name, int neighborhoodId, String mobileNumber, String address) async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client
        .createBranch(
      neighborhoodId,
      name,
      phoneNumberMask.unmaskText(mobileNumber),
      address,
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

  Future<bool> updateBranch() async {
    isDetectError = true;
    errorFields.clear();
    if (nameController.text.isEmpty) {
      errorFields.addAll({'name': R.string.invalidName});
    }
    if (!phoneNumberMask.unmaskText(phoneNumberController.text).isValidPhone()) {
      errorFields.addAll({'phone_number': R.string.invalidPhone});
    }
    if (addressController.text.isNullOrEmpty()) {
      errorFields.addAll({'address': R.string.invalidAddress});
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
    notifyListeners();
    if (errorFields.isNotEmpty) {
      return false;
    }
    return _updateBranch(nameController.text, selectedNeighborhood?.id ?? 0, phoneNumberMask.unmaskText(phoneNumberController.text), addressController.text);
  }

  Future<bool> _updateBranch(String name, int neighborhoodId, String mobileNumber, String address) async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client
        .updateBranch(
      data?.id ?? 0,
      neighborhoodId,
      name,
      mobileNumber,
      address,
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
