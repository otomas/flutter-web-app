import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/extensions/extension_bool.dart';
import '../../../core/resources/_r.dart';
import '../../../core/services/router/router.gr.dart';
import '../../base/base_view.dart';
import '../../widgets/widget_button.dart';
import '../../widgets/widget_textfield.dart';
import '../../widgets/widget_web.dart';
import '../../widgets/widgets_text.dart';
import 'vm_forgot_password.dart';

@RoutePage()
class ViewForgotPassword extends WidgetBase<VmForgotPassword> {
  const ViewForgotPassword({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmForgotPassword createViewModel(BuildContext context) => VmForgotPassword(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmForgotPassword viewModel) => Scaffold(
        body: _getBody(context, viewModel),
        resizeToAvoidBottomInset: false,
        bottomSheet: _getForm(context, viewModel),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmForgotPassword viewModel) => Scaffold(
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

  Widget _getBody(BuildContext context, VmForgotPassword viewModel) => Stack(
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
            child: !isWeb(context)
                ? AppbarBackButton(
                    onPressed: () => unawaited(router(context).onBackPressed()),
                  )
                : Container(),
          ),
        ],
      );

  Widget _getForm(BuildContext context, VmForgotPassword viewModel) => Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: R.themeColor.viewBg,
          borderRadius: kIsWeb ? BorderRadius.circular(20) : const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: kIsWeb
              ? [
                  BoxShadow(
                    color: R.themeColor.viewText.withOpacity(0.26),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitle(context, viewModel),
                const SizedBox(height: 32),
                _getEmailField(context, viewModel),
                const SizedBox(height: 16),
                _getTaxNumberField(context, viewModel),
                const SizedBox(height: 20),
                _getAuthButtons(context, viewModel),
              ],
            ),
          ],
        ),
      );

  Widget _getTitle(BuildContext context, VmForgotPassword viewModel) => TextBasic(text: R.string.reminderPassword, color: R.themeColor.secondary, fontFamily: R.fonts.displayBold, fontSize: 24);

  Widget _getEmailField(BuildContext context, VmForgotPassword viewModel) => TextFieldBasic(
        controller: viewModel.emailController,
        title: R.string.urEmailAddress,
        hintText: R.string.emailAddress,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.username, AutofillHints.email],
        textInputAction: TextInputAction.go,
        isDense: false,
        hasError: viewModel.isDetectError && !viewModel.emailController.text.isValidEmail(),
        errorLabel: R.string.invalidEmail,
        onFieldSubmitted: (value) => requestFocus(context, viewModel.taxNumberFocusNode),
      );

  Widget _getTaxNumberField(BuildContext context, VmForgotPassword viewModel) => TextFieldBasic(
        controller: viewModel.taxNumberController,
        title: R.string.taxNo,
        hintText: R.string.taxNo,
        keyboardType: TextInputType.number,
        isDense: false,
        hasError: viewModel.isDetectError && !viewModel.taxNumberController.text.isValidTaxNumber(),
        maxLength: 10,
        errorLabel: R.string.invalidTaxNo,
      );

  Widget _getAuthButtons(BuildContext context, VmForgotPassword viewModel) => Row(
        children: [
          Expanded(
            child: ButtonBasic(
              bgColor: R.themeColor.primaryLight,
              textColor: R.themeColor.primary,
              text: R.string.login,
              onPressed: () => unawaited(router(context).startNewView(route: RouteLogin())),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ButtonBasic(
              text: R.string.resetMyPassword,
              onPressed: () async {
                if (await viewModel.resetPassword()) {
                  if (context.mounted) {
                    unawaited(router(context).startNewView(route: RouteLogin(), isReplace: true));
                  }
                }
              },
            ),
          ),
        ],
      );
}
