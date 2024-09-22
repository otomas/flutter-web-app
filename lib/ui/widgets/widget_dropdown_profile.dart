import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_app.dart';
import '../../core/utils/general_data.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widgets_text.dart';

class WidgetDropdownProfile extends WidgetBase<VmWidgetDropdownProfile> {
  const WidgetDropdownProfile({
    super.key,
    super.isActiveLoadingIndicator = false,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetDropdownProfile createViewModel(BuildContext context) => VmWidgetDropdownProfile();

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetDropdownProfile viewModel) => Column(
        children: [
          PopupMenuButton(
            tooltip: '',
            position: PopupMenuPosition.under,
            splashRadius: 12,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () {
                  di<ServiceApp>(context).tabsRouter.setActiveIndex(3);
                },
                child: ListTile(
                  title: TextBasic(
                    text: 'Bana Özel',
                    color: R.themeColor.secondaryHover,
                    fontSize: 14,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: () {
                    viewModel.logout();
                  },
                  title: TextBasic(
                    text: 'Çıkış Yap',
                    color: R.themeColor.error,
                    fontSize: 14,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
              ),
            ],
            child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: R.themeColor.borderLight,
                    width:2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right:16,left:12, bottom:6, top: 6),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        R.drawable.svg.iconProfile,
                        colorFilter: ColorFilter.mode(R.themeColor.secondaryHover, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 5),
                      TextBasic(
                        text: GeneralData.getInstance().getTokenData()?.firstName ?? '',
                        color: R.themeColor.secondaryHover,
                        fontSize: 14,
                        fontFamily: R.fonts.displayBold,
                      ),
                    ],
                  ),
                ),
              ),
          ),
        ],
      );

  @override
  Widget buildWidget(BuildContext context, VmWidgetDropdownProfile viewModel) => const SizedBox.shrink();
}

class VmWidgetDropdownProfile extends ViewModelBase {
  VmWidgetDropdownProfile() {
    init();
  }
  @override
  void init() {}
}
