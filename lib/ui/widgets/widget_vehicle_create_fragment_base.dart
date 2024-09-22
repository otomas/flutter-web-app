import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/resources/_r.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widget_button.dart';
import 'widgets_text.dart';

class WidgetVehicleCreateFragmentBase extends WidgetBase<VmWidgetVehicleCreateFragmentBase> {
  const WidgetVehicleCreateFragmentBase({
    required this.stepTitle,
    required this.title,
    required this.previousButtonText,
    required this.onPressedPreviousButton,
    required this.nextButtonText,
    required this.onPressedNextButton,
    required this.child,
    super.key,
  });

  final String stepTitle;
  final String title;
  final String previousButtonText;
  final Function() onPressedPreviousButton;
  final String nextButtonText;
  final Function() onPressedNextButton;
  final Widget child;

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetVehicleCreateFragmentBase createViewModel(BuildContext context) => VmWidgetVehicleCreateFragmentBase();

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetVehicleCreateFragmentBase viewModel) => Column(
    children: [
      const SizedBox(height: 40),
      _getHeader(context),
      Expanded(child: child),
    ],
  );

  @override
  Widget buildWidget(BuildContext context, VmWidgetVehicleCreateFragmentBase viewModel) => Column(
        children: [
          Expanded(child: child),
          _getButtons(context),
        ],
      );

  Widget _getHeader(BuildContext context) => Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                const SizedBox(width: 40),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBasic(
                        text: stepTitle,
                        color: R.themeColor.smoke,
                        fontFamily: R.fonts.displayMedium,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 10),
                      TextBasic(
                        text: title,
                        color: R.themeColor.secondary,
                        fontFamily: R.fonts.displayBold,
                        fontSize: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 3,
                  child: _getButtons(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: R.themeColor.border),
        ],
      );

  Widget _getButtons(BuildContext context) => WidgetVehicleCreateButtons(
        previousButtonText: previousButtonText,
        onPressedPreviousButton: onPressedPreviousButton,
        nextButtonText: nextButtonText,
        onPressedNextButton: onPressedNextButton,
      );
}

class VmWidgetVehicleCreateFragmentBase extends ViewModelBase {
  VmWidgetVehicleCreateFragmentBase() {
    init();
  }

  @override
  void init() {}
}

class WidgetVehicleCreateButtons extends StatelessWidget with BaseView {
  const WidgetVehicleCreateButtons({
    required this.previousButtonText,
    required this.onPressedPreviousButton,
    required this.nextButtonText,
    required this.onPressedNextButton,
    super.key,
  });

  final String previousButtonText;
  final Function() onPressedPreviousButton;

  final String nextButtonText;
  final Function() onPressedNextButton;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(
          bottom: isWeb(context) ? 0 : systemPadding(context).bottom + 4.0,
          left: 20,
          right: 20,
        ),
        child: Row(
          children: [
            Expanded(
              child: ButtonBasic(
                onPressed: onPressedPreviousButton,
                text: previousButtonText,
                bgColor: R.color.transparent,
                textColor: R.themeColor.secondaryHover,
                fontFamily: R.fonts.displayMedium,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: ButtonBasic(
                onPressed: onPressedNextButton,
                bgColor: R.themeColor.primary,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: size(context).height * 0.025),
                child: Row(
                  children: [
                    Expanded(
                      child: TextBasic(
                        text: nextButtonText,
                        color: R.themeColor.viewBg,
                        fontFamily: R.fonts.displayBold,
                        fontSize: 14,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: R.themeColor.viewBg, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
