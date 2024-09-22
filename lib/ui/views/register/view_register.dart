// ignore_for_file: require_trailing_commas

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/extensions/extension_bool.dart';
import '../../../core/extensions/extension_date.dart';
import '../../../core/extensions/extension_string.dart';
import '../../../core/models/model_district.dart';
import '../../../core/models/response/model_response_city.dart';
import '../../../core/models/response/model_response_country.dart';
import '../../../core/resources/_r.dart';
import '../../../core/services/router/router.gr.dart';
import '../../../core/utils/alert_utils.dart';
import '../../../core/utils/general_data.dart';
import '../../base/base_view.dart';
import '../../widgets/widget_button.dart';
import '../../widgets/widget_checkbox.dart';
import '../../widgets/widget_dropdown.dart';
import '../../widgets/widget_scroll.dart';
import '../../widgets/widget_textfield.dart';
import '../../widgets/widget_web.dart';
import '../../widgets/widgets_text.dart';
import 'vm_register.dart';

@RoutePage()
class ViewRegister extends WidgetBase<VmRegister> {
  const ViewRegister({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmRegister createViewModel(BuildContext context) => VmRegister(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmRegister viewModel) => Scaffold(
        body: _getBodyPhone(context, viewModel),
        resizeToAvoidBottomInset: false,
        bottomSheet: _getForm(context, viewModel),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmRegister viewModel) => Scaffold(
        body: WidgetWebBase(
          child: Stack(
            children: [
              Image.asset(
                R.drawable.loginBg(isWeb(context)),
                height: size(context).height,
                width: size(context).width,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: size(context).width * 0.335,
                left: size(context).width * 0.335,
                top: 0,
                bottom: 0,
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 24,
                          color: R.themeColor.viewText.withOpacity(0.15),
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: _getFormWeb(context, viewModel),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _getBodyPhone(BuildContext context, VmRegister viewModel) => Stack(
        children: [
          Image.asset(
            R.drawable.loginBg(isWeb(context)),
            height: size(context).height,
            width: size(context).width,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: systemPadding(context).top + 20,
            left: 20,
            child: AppbarBackButton(
              onPressed: () => unawaited(router(context).onBackPressed()),
            ),
          ),
        ],
      );


  Widget _getForm(BuildContext context, VmRegister viewModel) => Container(
        constraints: BoxConstraints(maxHeight: size(context).height * 0.8),
        decoration: BoxDecoration(
          color: R.color.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: R.color.black.withOpacity(0.26),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ScrollWithNoGlowWidget(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _getHeader(context, viewModel),
              const SizedBox(height: 20),
              _getMembershipTypes(context, viewModel),
              const SizedBox(height: 20),
              _getTitle(context, viewModel),
              const SizedBox(height: 20),
              if (viewModel.selectedMembershipType != viewModel.constantMemberShipType.legalEntity) _getTitleField(context, viewModel, false) else _getTitleField(context, viewModel, true),
              const SizedBox(height: 20),
              _getNameField(context, viewModel),
              const SizedBox(height: 20),
              _getSurnameField(context, viewModel),
              const SizedBox(height: 20),
              _getTcNumberField(context, viewModel),
              const SizedBox(height: 20),
              _getBirthDateField(context, viewModel),
              const SizedBox(height: 20),
              _getPhoneNumberField(context, viewModel),
              const SizedBox(height: 20),
              _getEmailField(context, viewModel),
              const SizedBox(height: 20),
              if (viewModel.selectedMembershipType != viewModel.constantMemberShipType.legalEntity) Container() else _getCompanyTitle(context, viewModel),
              const SizedBox(height: 20),
              _getCompanyInfoFields(context, viewModel),
              const SizedBox(height: 20),
              _getAddressField(context, viewModel),
              if (viewModel.selectedMembershipType != viewModel.constantMemberShipType.legalEntity) Container() else const SizedBox(height: 20),
              if (viewModel.selectedMembershipType != viewModel.constantMemberShipType.legalEntity) Container() else _getCompanyNumberFields(context, viewModel),
              if (viewModel.selectedMembershipType != viewModel.constantMemberShipType.legalEntity) Container() else const SizedBox(height: 20),
              if (viewModel.selectedMembershipType != viewModel.constantMemberShipType.legalEntity) Container() else _getCompanyEmailField(context, viewModel),
              const SizedBox(height: 20),
              _getPasswordTitle(context, viewModel),
              const SizedBox(height: 20),
              _getPasswordFields(context, viewModel),
              const SizedBox(height: 20),
              _getTermsAndConditionCheckBox(context, viewModel),
              const SizedBox(height: 20),
              _getButtons(context, viewModel),
            ],
          ),
        ),
      );

  Widget _getFormWeb(BuildContext context, VmRegister viewModel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        constraints: BoxConstraints(maxHeight: size(context).height * 0.8),
        decoration: BoxDecoration(
          color: R.color.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: R.color.black.withOpacity(0.26),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ScrollWithNoGlowWidget(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _getHeader(context, viewModel),
              const SizedBox(height: 20),
              _getMembershipTypes(context, viewModel),
              const SizedBox(height: 20),
              _getTitle(context, viewModel),
              const SizedBox(height: 20),
              _getTitleField(context, viewModel, viewModel.selectedMembershipType != viewModel.constantMemberShipType.legalEntity),
              const SizedBox(height: 20),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _getNameField(context, viewModel),
                          const SizedBox(height: 20),
                          _getSurnameField(context, viewModel),
                          const SizedBox(height: 20),
                          _getTcNumberField(context, viewModel),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    VerticalDivider(width: 1, color: R.themeColor.secondaryLight),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _getBirthDateField(context, viewModel),
                          const SizedBox(height: 20),
                          _getPhoneNumberField(context, viewModel),
                          const SizedBox(height: 20),
                          _getEmailField(context, viewModel),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _getCompanyTitle(context, viewModel),
              const SizedBox(height: 20),
              _getCompanyInfoFields(context, viewModel),
              const SizedBox(height: 20),
              _getAddressField(context, viewModel),
              const SizedBox(height: 20),
              _getCompanyNumberFields(context, viewModel),
              const SizedBox(height: 20),
              _getPasswordTitle(context, viewModel),
              const SizedBox(height: 20),
              _getPasswordFields(context, viewModel),
              const SizedBox(height: 20),
              _getTermsAndConditionCheckBox(context, viewModel),
              const SizedBox(height: 20),
              _getButtons(context, viewModel),
            ],
          ),
        ),
      );

  Widget _getHeader(BuildContext context, VmRegister viewModel) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextBasic(
          text: R.string.newMemberForm,
          color: R.themeColor.secondary,
          fontFamily: R.fonts.displayBold,
          fontSize: 24,
        ),
      );

  Widget _getMembershipTypes(BuildContext context, VmRegister viewModel) => ScrollWithNoGlowWidget(
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

  Widget _getTitle(BuildContext context, VmRegister viewModel) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: TextBasic(
                text: viewModel.selectedMembershipType != viewModel.constantMemberShipType.legalEntity ? R.string.contactInfo : R.string.companyInfo,
                color: R.themeColor.secondary,
                fontFamily: R.fonts.displayMedium,
                fontSize: 16,
              ),
            ),
            RichTextBasic(texts: R.string.requiredFielsMsg.highlightOccurrences('*', textColor: R.themeColor.secondary, fontSize: 12, boldTextColor: R.color.candy)),
          ],
        ),
      );

  Widget _getTitleField(BuildContext context, VmRegister viewModel, bool isRequired) => TextFieldBasic(
        controller: viewModel.titleController,
        focusNode: viewModel.titleFocusNode,
        title: R.string.title,
        textInputAction: TextInputAction.go,
        isRequired: isRequired,
        hasError: viewModel.detectFieldError && viewModel.titleController.text.isEmpty && isRequired,
        errorLabel: isRequired ? R.string.invalidTitle : null,
        onFieldSubmitted: (v) => requestFocus(context, viewModel.nameFocusNode),
      );

  Widget _getNameField(BuildContext context, VmRegister viewModel) => TextFieldBasic(
        controller: viewModel.nameController,
        focusNode: viewModel.nameFocusNode,
        title: R.string.name,
        textInputAction: TextInputAction.go,
        autofillHints: const [AutofillHints.username],
        isRequired: true,
        hasError: viewModel.detectFieldError && viewModel.nameController.text.isEmpty,
        errorLabel: R.string.invalidName,
        onFieldSubmitted: (v) => requestFocus(context, viewModel.surnameFocusNode),
      );

  Widget _getSurnameField(BuildContext context, VmRegister viewModel) => TextFieldBasic(
        controller: viewModel.surnameController,
        focusNode: viewModel.surnameFocusNode,
        title: R.string.surname,
        textInputAction: TextInputAction.go,
        isRequired: true,
        hasError: viewModel.detectFieldError && viewModel.surnameController.text.isEmpty,
        errorLabel: R.string.invalidSurname,
        onFieldSubmitted: (v) => requestFocus(context, viewModel.tcNumberFocusNode),
      );

  Widget _getTcNumberField(BuildContext context, VmRegister viewModel) => TextFieldBasic(
        controller: viewModel.tcNumberController,
        focusNode: viewModel.tcNumberFocusNode,
        title: R.string.tcNumber,
        hasError: viewModel.detectFieldError && !viewModel.tcNumberController.text.isValidTCIdentityNumber(),
        errorLabel: R.string.invalidTcNo,
        isRequired: true,
      );

  Widget _getBirthDateField(BuildContext context, VmRegister viewModel) => GestureDetector(
        onTap: () => showBirthDateSelection(context, viewModel),
        child: TextFieldBasic(
          enabled: false,
          controller: viewModel.birthDateController,
          title: R.string.birthDate,
          isRequired: true,
          hasError: viewModel.detectFieldError && viewModel.birthDate == null,
          errorLabel: R.string.invalidDate,
          suffixIcon: Icon(Icons.calendar_today_outlined, color: R.themeColor.primary),
        ),
      );

  Widget _getPhoneNumberField(BuildContext context, VmRegister viewModel) => TextFieldBasic(
        controller: viewModel.phoneNumberController,
        focusNode: viewModel.phoneNumberFocusNode,
        title: R.string.urPhoneNumber,
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.number,
        isRequired: true,
        hintText: '(500) 000 00 00',
        hasError: viewModel.detectFieldError && !viewModel.phoneNumberMask.getUnmaskedText().isValidPhone(),
        errorLabel: R.string.invalidPhone,
        inputFormatters: [viewModel.phoneNumberMask],
        onFieldSubmitted: (v) => requestFocus(context, viewModel.emailFocusNode),
      );

  Widget _getEmailField(BuildContext context, VmRegister viewModel) => TextFieldBasic(
        controller: viewModel.emailController,
        focusNode: viewModel.emailFocusNode,
        title: R.string.urEmailAddress,
        autofillHints: const [AutofillHints.username, AutofillHints.email],
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.emailAddress,
        hasError: viewModel.detectFieldError && !viewModel.emailController.text.isValidEmail(),
        errorLabel: R.string.invalidEmail,
        isRequired: true,
        onFieldSubmitted: (v) => requestFocus(context, viewModel.taxOfficeFocusNode),
      );

  Widget _getCompanyTitle(BuildContext context, VmRegister viewModel) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextBasic(text: R.string.companyContactInfo, color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayMedium, fontSize: 16),
      );

  Widget _getCompanyInfoFields(BuildContext context, VmRegister viewModel) => IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: _getCompanyInfo(context, viewModel)),
            const SizedBox(width: 20),
            VerticalDivider(width: 1, color: R.themeColor.secondaryLight),
            const SizedBox(width: 20),
            if (viewModel.selectedMembershipType != viewModel.constantMemberShipType.legalEntity) Container() else const SizedBox(width: 20),
            Expanded(child: _getAddressFields(context, viewModel)),
          ],
        ),
      );

  Widget _getCompanyInfo(BuildContext context, VmRegister viewModel) => Column(
        children: [
          GestureDetector(
            onTap: () => showCompanyDateSelection(context, viewModel),
            child: TextFieldBasic(
              enabled: false,
              controller: viewModel.companyCreatedDateController,
              title: R.string.createdDate,
              isRequired: viewModel.selectedMembershipType == viewModel.constantMemberShipType.legalEntity,
              hasError: viewModel.detectFieldError && viewModel.companyCreatedDate == null,
              errorLabel: R.string.invalidDate,
              suffixIcon: Icon(Icons.calendar_today_outlined, color: R.themeColor.primary),
            ),
          ),
          const SizedBox(height: 20),
          TextFieldBasic(
            controller: viewModel.taxOfficeController,
            focusNode: viewModel.taxOfficeFocusNode,
            title: R.string.taxOffice,
            textInputAction: TextInputAction.go,
            hasError: viewModel.detectFieldError && viewModel.taxOfficeController.text.isEmpty,
            errorLabel: R.string.invalidValue,
            isRequired: viewModel.selectedMembershipType == viewModel.constantMemberShipType.legalEntity,
          ),
          const SizedBox(height: 20),
          TextFieldBasic(
            controller: viewModel.taxNoController,
            focusNode: viewModel.taxNoFocusNode,
            title: R.string.taxNo,
            hasError: viewModel.detectFieldError && viewModel.taxNoController.text.isEmpty,
            errorLabel: R.string.invalidValue,
            isRequired: viewModel.selectedMembershipType == viewModel.constantMemberShipType.legalEntity,
          ),
        ],
      );

  Widget _getAddressFields(BuildContext context, VmRegister viewModel) => Column(
        children: [
          _getCountryDropdown(context, viewModel),
          const SizedBox(height: 20),
          _getCityDropdown(context, viewModel),
          const SizedBox(height: 20),
          _getDistrictDropdown(context, viewModel),
        ],
      );

  Widget _getCountryDropdown(BuildContext context, VmRegister viewModel) => DropdownBasic<ModelCountry>(
        title: R.string.countrySelection,
        selectedItem: viewModel.selectedCountry,
        // ignore: discarded_futures
        callback: () => viewModel.serviceApi.client.getCountries(),
        hasError: viewModel.detectFieldError && viewModel.selectedCountry == null,
        errorLabel: R.string.pleaseSelect,
        isRequired: true,
        onChanged: viewModel.setSelectedCountry,
      );

  Widget _getCityDropdown(BuildContext context, VmRegister viewModel) => DropdownBasic<ModelCity>(
        key: ValueKey(viewModel.selectedCountry),
        title: R.string.citySelection,
        selectedItem: viewModel.selectedCity,
        // ignore: discarded_futures
        callback: () => viewModel.serviceApi.client.getCities(viewModel.selectedCountry!.id),
        hasError: viewModel.detectFieldError && viewModel.selectedCity == null,
        errorLabel: R.string.pleaseSelect,
        isRequired: true,
        onChanged: viewModel.setSelectedCity,
        customOnTap: viewModel.selectedCountry != null
            ? null
            : () {
                viewModel.errorObserver.message = R.string.pleaseSelectCountry;
              },
      );

  Widget _getDistrictDropdown(BuildContext context, VmRegister viewModel) => DropdownBasic<ModelDistrict>(
        key: ValueKey(viewModel.selectedCity),
        title: R.string.districtSelection,
        selectedItem: viewModel.selectedDistrict,
        // ignore: discarded_futures
        callback: () => viewModel.serviceApi.client.getDistricts(viewModel.selectedCity!.id),
        hasError: viewModel.detectFieldError && viewModel.selectedDistrict == null,
        errorLabel: R.string.pleaseSelect,
        isRequired: true,
        onChanged: viewModel.setSelectedDistrict,
        customOnTap: viewModel.selectedCity != null
            ? null
            : () {
                viewModel.errorObserver.message = R.string.pleaseSelectCity;
              },
      );

  Widget _getAddressField(BuildContext context, VmRegister viewModel) => TextFieldBasic(
        controller: viewModel.addressController,
        focusNode: viewModel.addressFocusNode,
        title: R.string.address,
        textInputAction: TextInputAction.go,
        hasError: viewModel.detectFieldError && viewModel.addressController.text.isEmpty,
        errorLabel: R.string.invalidAddress,
        isRequired: true,
        onFieldSubmitted: (v) => requestFocus(context, viewModel.companyPhoneNumberFocusNode),
      );

  Widget _getCompanyNumberFields(BuildContext context, VmRegister viewModel) => Row(
        children: [
          Expanded(
            child: TextFieldBasic(
              controller: viewModel.companyPhoneNumberController,
              focusNode: viewModel.companyPhoneNumberFocusNode,
              title: R.string.fixedPhoneNumber,
              textInputAction: TextInputAction.go,
              hasError: viewModel.detectFieldError && !viewModel.companyPhoneNumberMask.getUnmaskedText().isValidPhone(),
              errorLabel: R.string.invalidPhone,
              inputFormatters: [viewModel.companyPhoneNumberMask],
              hintText: '(000) 000 00 00',
              onFieldSubmitted: (v) => requestFocus(context, viewModel.companyFaxNoFocusNode),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFieldBasic(
              controller: viewModel.companyFaxNoController,
              focusNode: viewModel.companyFaxNoFocusNode,
              title: R.string.faxNo,
              textInputAction: TextInputAction.go,
              hasError: viewModel.detectFieldError && !viewModel.companyFaxPhoneNumberMask.getUnmaskedText().isValidPhone(),
              errorLabel: R.string.invalidPhone,
              inputFormatters: [viewModel.companyFaxPhoneNumberMask],
              hintText: '(000) 000 00 00',
              onFieldSubmitted: (v) => requestFocus(context, viewModel.companyEmailFocusNode),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: _getCompanyEmailField(context, viewModel),
          ),
        ],
      );

  Widget _getCompanyEmailField(BuildContext context, VmRegister viewModel) => TextFieldBasic(
        controller: viewModel.companyEmailAddressController,
        focusNode: viewModel.companyEmailFocusNode,
        title: R.string.accountingEmailAddress,
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.emailAddress,
        hasError: viewModel.detectFieldError && !viewModel.companyEmailAddressController.text.isValidEmail(),
        errorLabel: R.string.invalidEmail,
        onFieldSubmitted: (v) => requestFocus(context, viewModel.passwordFocusNode),
      );

  Widget _getPasswordTitle(BuildContext context, VmRegister viewModel) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextBasic(text: R.string.setYourPassword, color: R.themeColor.secondary, fontFamily: R.fonts.displayMedium, fontSize: 16),
      );

  Widget _getPasswordFields(BuildContext context, VmRegister viewModel) => Row(
        children: [
          Expanded(
            child: TextFieldBasic(
              controller: viewModel.passwordController,
              focusNode: viewModel.passwordFocusNode,
              title: R.string.password,
              textInputAction: TextInputAction.go,
              isRequired: true,
              isPassword: true,
              autofillHints: const [AutofillHints.password],
              hasError: viewModel.detectFieldError && !viewModel.passwordController.text.isValidPassword(),
              errorLabel: R.string.invalidPassword,
              onFieldSubmitted: (v) => requestFocus(context, viewModel.passwordConfirmFocusNode),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFieldBasic(
              controller: viewModel.passwordConfirmController,
              focusNode: viewModel.passwordConfirmFocusNode,
              title: R.string.passwordConfirm,
              autofillHints: const [AutofillHints.password],
              isRequired: true,
              isPassword: true,
              hasError: viewModel.detectFieldError && (viewModel.passwordConfirmController.text != viewModel.passwordController.text || !viewModel.passwordController.text.isValidPassword()),
              errorLabel: !viewModel.passwordController.text.isValidPassword() ? R.string.invalidPassword : R.string.passwordNotMatch,
            ),
          ),
        ],
      );

  Widget _getTermsAndConditionCheckBox(BuildContext context, VmRegister viewModel) => CheckboxBasic(
        item: viewModel.termsAndCondition,
        value: viewModel.isCheckedTermsAndCondition,
        onChanged: viewModel.setTermsAndConditionState,
      );

  Widget _getButtons(BuildContext context, VmRegister viewModel) => Padding(
        padding: EdgeInsets.only(bottom: kIsWeb ? 0.0 : systemPadding(context).bottom + 4.0),
        child: Row(
          children: [
            const Expanded(flex: 2, child: SizedBox()),
            Expanded(
              child: ButtonBasic(
                bgColor: R.color.transparent,
                textColor: R.themeColor.smoke,
                text: R.string.login,
                onPressed: () => unawaited(router(context).startNewView(route: RouteLogin(), isReplace: true, clearStack: true)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ButtonBasic(
                text: R.string.signUp,
                bgColor: R.color.river,
                onPressed: () async {
                  if (await viewModel.register()) {
                    if (context.mounted) {
                      await router(context).onBackPressed();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      );

  void showBirthDateSelection(BuildContext context, VmRegister viewModel) {
    unawaited(
      showCustomDatePicker(
        context,
        initial: viewModel.birthDate,
        min: GeneralData.getInstance().serverTime.add(const Duration(days: -(365 * 120))),
        max: GeneralData.getInstance().serverTime.add(const Duration(days: -(365 * 18))),
        onConfirm: (date, _) {
          viewModel.birthDate = date;
          viewModel.birthDateController.text = date.dayMonthNameAndYear();
        },
      ),
    );
  }

  void showCompanyDateSelection(BuildContext context, VmRegister viewModel) {
    unawaited(
      showCustomDatePicker(
        context,
        initial: viewModel.companyCreatedDate,
        onConfirm: (date, _) {
          viewModel.companyCreatedDate = date;
          viewModel.companyCreatedDateController.text = date.dayMonthNameAndYear();
        },
      ),
    );
  }
}
