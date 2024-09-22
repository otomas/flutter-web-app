import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/ui/widgets/widget_textfield.dart';
import '/ui/widgets/widgets_text.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/extensions/extension_bool.dart';
import '../../../core/resources/_r.dart';
import '../../../core/services/router/router.gr.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widget_button.dart';
import '../../widgets/widget_web.dart';
import 'vm_login.dart';

@RoutePage()
class ViewLogin extends WidgetBase<VmLogin> {
  const ViewLogin({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmLogin createViewModel(BuildContext context) => VmLogin(apiService(context), router(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmLogin viewModel) => Scaffold(
        body: WidgetWebBase(
          child: Stack(
            children: [
              _getBody(context, viewModel),
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
                    child: _getForm(context, viewModel),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget buildWidget(BuildContext context, VmLogin viewModel) => Scaffold(
        body: _getBody(context, viewModel),
        resizeToAvoidBottomInset: false,
        bottomSheet: _getForm(context, viewModel),
      );

  Widget _getBody(BuildContext context, VmLogin viewModel) => Image.asset(
        R.drawable.loginBg(isWeb(context)),
        height: size(context).height,
        width: size(context).width,
        fit: BoxFit.cover,
      );

  Widget _getForm(BuildContext context, VmLogin viewModel) => Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: R.color.white,
          borderRadius: BorderRadius.vertical(top: const Radius.circular(20), bottom: isWeb(context) ? const Radius.circular(20) : Radius.zero),
        ),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getLoginTitle(context, viewModel),
                const SizedBox(height: 32),
                _getUsernameField(context, viewModel),
                const SizedBox(height: 20),
                _getPasswordField(context, viewModel),
                const SizedBox(height: 20),
                _getTaxNumberField(context, viewModel),
                const SizedBox(height: 20),
                _getForgotPasswordButton(context, viewModel),
                const SizedBox(height: 20),
                _getAuthButtons(context, viewModel),
              ],
            ),
          ],
        ),
      );

  Widget _getLoginTitle(BuildContext context, VmLogin viewModel) => TextBasic(
        text: R.string.urlogin,
        color: R.themeColor.secondary,
        fontFamily: R.fonts.displayBold,
        fontSize: 24,
      );

  Widget _getUsernameField(BuildContext context, VmLogin viewModel) => TextFieldBasic(
        controller: viewModel.usernameController,
        focusNode: viewModel.usernameFocusNode,
        title: R.string.urUsername,
        hintText: R.string.username,
        textInputAction: TextInputAction.next,
        isDense: false,
        autofillHints: const [AutofillHints.username, AutofillHints.email],
        keyboardType: TextInputType.emailAddress,
        hasError: viewModel.detectFieldError && viewModel.usernameController.text.isEmpty,
        errorLabel: R.string.invalidUsername,
        onFieldSubmitted: (v) => requestFocus(context, viewModel.passwordFocusNode),
      );

  Widget _getPasswordField(BuildContext context, VmLogin viewModel) => TextFieldBasic(
        controller: viewModel.passwordController,
        focusNode: viewModel.passwordFocusNode,
        title: R.string.urPassword,
        hintText: R.string.password,
        isPassword: true,
        isDense: false,
        autofillHints: const [AutofillHints.password],
        hasError: viewModel.detectFieldError && !viewModel.passwordController.text.isValidPassword(),
        errorLabel: R.string.invalidPassword,
        onFieldSubmitted: (v) => requestFocus(context, viewModel.taxNumberFocusNode),
        
      );

  Widget _getTaxNumberField(BuildContext context, VmLogin viewModel) => TextFieldBasic(
        controller: viewModel.taxNumberController,
        focusNode: viewModel.taxNumberFocusNode,
        title: R.string.taxNo,
        hintText: R.string.taxNo,
        keyboardType: TextInputType.number,
        isDense: false,
        hasError: viewModel.detectFieldError && !viewModel.taxNumberController.text.isValidTaxNumber(),
        errorLabel: R.string.invalidTaxNo,
      );

  Widget _getForgotPasswordButton(BuildContext context, VmLogin viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonBasic(
            onPressed: () {
              unawaited(router(context).startNewView(route: RouteForgotPassword()));
            },
            bgColor: R.color.white,
            textColor: R.themeColor.primary,
            text: R.string.didYouForgotPassword,
            padding: EdgeInsets.zero,
          ),
        ],
      );

  Widget _getAuthButtons(BuildContext context, VmLogin viewModel) => Row(
        children: [
          Expanded(
            child: ButtonBasic(
              bgColor: R.color.transparent,
              textColor: R.themeColor.secondaryHover,
              text: R.string.signUp,
              onPressed: () async => router(context).startNewView(route: RouteRegister()),
            ),
          ),
          const SizedBox(width: 12),
            Expanded(
              child: ButtonBasic(
                text: R.string.login,
                elevation: 2,
                onPressed: () => unawaited(login(context, viewModel)),
              ),
            ),

        ],
      );

  Future<void> login(BuildContext context, VmLogin viewModel) async {
    if (await viewModel.login() && context.mounted) {
      unawaited(router(context).startNewView(route: RouteHome(), clearStack: true, isReplace: true));
    }
  }
}
