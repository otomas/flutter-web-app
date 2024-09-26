import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/enums/enum_app.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widget_button.dart';
import 'widget_expandable.dart';
import 'widget_flexible.dart';
import 'widgets_text.dart';

class WidgetInfoCard extends WidgetBase<VmWidgetInfoCard> {
  const WidgetInfoCard({
    this.width,
    super.key,
    this.title,
    this.description,
    this.icon,
    this.crossButtonVisibility = false,
    this.bgColor,
    this.startColor,
    this.endColor,
    this.iconColor,
    this.onButtonAction,
    this.buttonText,
    this.isDescHighlighted,
  });

  final String? title;
  final String? description;
  final IconData? icon;
  final Color? iconColor;
  final bool crossButtonVisibility;
  final Color? bgColor;
  final Color? startColor;
  final Color? endColor;
  final double? width;
  final Function()? onButtonAction;
  final String? buttonText;
  final bool? isDescHighlighted;

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetInfoCard createViewModel(BuildContext context) => VmWidgetInfoCard(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetInfoCard viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetInfoCard viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmWidgetInfoCard viewModel) {
    if (!viewModel.isVisible) {
      return const SizedBox.shrink();
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: 180,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: (startColor == null || endColor == null) ? bgColor : null,
          gradient: startColor != null && endColor != null ? LinearGradient(colors: [startColor!, endColor!]) : null,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Stack(
          children: [
            WidgetFlexible(
              isRow: isWeb(context),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (icon != null) Container(margin: const EdgeInsets.all(20), child: Icon(icon, color: iconColor, size: 56)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null) TextBasic(text: title ?? '', fontSize: 24, fontWeight: FontWeight.bold, color: R.color.black),
                      const SizedBox(height: 15),
                      if (description != null)
                        DecoratedBox(
                          decoration: BoxDecoration(color: isDescHighlighted != null ? R.themeColor.highlightedHover : Colors.transparent),
                          child: TextBasic(text: description ?? '', fontSize: 18, color: R.color.black),
                        ),
                    ],
                  ),
                ),
                if (onButtonAction != null)
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetExpandable(
                          isExpanded: !isWeb(context),
                          child: ButtonBasic(
                            bgColor: R.themeColor.primary,
                            text: buttonText,
                            textColor: R.color.white,
                            onPressed: onButtonAction,
                            radius: 32,
                            minWidth: 160,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!isWeb(context)) const SizedBox(height: 10) else const SizedBox(width: 10),
              ],
            ),
            if (crossButtonVisibility)
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.close, color: iconColor ?? R.themeColor.secondary),
                  onPressed: () {
                    viewModel.changeVisibility();
                  },
                ),
              ),
          ],
        ),
      );
    }
  }
}

class VmWidgetInfoCard extends ViewModelBase {
  VmWidgetInfoCard(this.serviceApi) {
    unawaited(init());
  }

  final ServiceApi serviceApi;

  bool isVisible = true;

  @override
  Future<void> init() async {
    unawaited(getData());
  }

  void changeVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    setActivityState(ActivityState.isLoaded);
  }
}
