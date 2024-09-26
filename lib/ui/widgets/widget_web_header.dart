import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_balance.dart';
import '../../core/resources/_r.dart';
import '../../core/services/router/router.gr.dart';
import '../../core/utils/general_data.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widget_button.dart';
import 'widget_dropdown_profile.dart';
import 'widget_info_box.dart';
import 'widget_textfield.dart';

class WidgetWebHeader extends WidgetBase<VmWidgetWebHeader> {
  const WidgetWebHeader({
    super.key,
    super.isActiveLoadingIndicator = false,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetWebHeader createViewModel(BuildContext context) => VmWidgetWebHeader();

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetWebHeader viewModel) => Container(
        padding: EdgeInsets.only(
          top: 16,
          left: size(context).width * 0.05,
          right: size(context).width * 0.05,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: R.themeColor.viewBg,
          border: Border(bottom: BorderSide(color: R.themeColor.borderLight)),
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () => unawaited(router(context).startNewView(route: RouteHome(), isReplace: !kIsWeb)),
              focusColor: R.color.transparent,
              hoverColor: R.color.transparent,
              splashColor: R.color.transparent,
              highlightColor: R.color.transparent,
              child: SvgPicture.asset(R.drawable.svg.logo),
            ),
            Expanded(flex: 2, child: Container()),
            if (GeneralData.getInstance().getAuthState() == AuthState.authenticated)
              Expanded(
                flex: 2,
                child: TextFieldBasic(
                  bgColor: R.color.transparent,
                  fillColor: R.themeColor.viewBg,
                  borderColor: R.themeColor.borderLight,
                  suffixIcon: SvgPicture.asset(R.drawable.svg.iconSearch),
                  hintText: 'Ne aramıştınız?',
                ),
              ),
            Expanded(child: Container()),
            if (GeneralData.getInstance().getAuthState() != AuthState.authenticated) ...[
              ButtonBasic(
                onPressed: () => unawaited(router(context).startNewView(route: RouteLogin())),
                text: 'Giriş Yap',
                textColor: R.themeColor.secondaryHover,
                splashColor: R.color.transparent,
                bgColor: R.themeColor.viewBg,
              ),
              const SizedBox(width: 5),
              ButtonBasic(
                onPressed: () {},
                text: 'Ücretsiz Üye Ol',
                bgColor: R.themeColor.primaryLight,
                textColor: R.themeColor.primary,
              ),
            ] else ...[
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(R.drawable.svg.iconChat),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(R.drawable.svg.iconNotification),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 5),
              const WidgetDropdownProfile(),
              const SizedBox(width: 16),
              WidgetInfoBox(
                title: GeneralData.getInstance().getTokenData()?.balance.formatPrice() ?? '0.00₺',
                bgColor: R.themeColor.successLight,
                textColor: R.themeColor.success,
              ),
              const SizedBox(width: 5),
              ButtonBasic(
                onPressed: () {
                  router(context).startVehicleCreateView(context);
                },
                bgColor: R.themeColor.primary,
                borderSide: BorderSide(color: R.themeColor.primary),
                text: '+ Yeni Araç Ekle',
                textColor: R.themeColor.viewBg,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ],
          ],
        ),
      );

  @override
  Widget buildWidget(BuildContext context, VmWidgetWebHeader viewModel) => const SizedBox.shrink();
}

class VmWidgetWebHeader extends ViewModelBase {
  VmWidgetWebHeader() {
    init();
  }
  @override
  void init() {}
}
