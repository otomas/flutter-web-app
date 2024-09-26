import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/resources/_r.dart';
import '../../../core/utils/general_data.dart';
import '../../base/base_view.dart';
import '../../widgets/widget_scroll.dart';
import '../../widgets/widget_web.dart';
import '../../widgets/widgets_text.dart';
import 'vm_public_list.dart';

@RoutePage()
class ViewPublicListing extends WidgetBase<VmPublicListing> {
  const ViewPublicListing({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmPublicListing createViewModel(BuildContext context) => VmPublicListing(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmPublicListing viewModel) => Scaffold(
        key: viewModel.scaffoldkey,
        appBar: _getAppBar(context, viewModel),
        body: _getBody(context, viewModel),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmPublicListing viewModel) => Scaffold(
        body: WidgetWebBase(
          child: _getBody(context, viewModel),
        ),
      );

  AppBar _getAppBar(BuildContext context, VmPublicListing viewModel) => AppBar(
        centerTitle: false,
        backgroundColor: R.color.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBasic(text: R.string.hello, color: R.themeColor.smoke, fontFamily: R.fonts.displayMedium, fontSize: 12),
                  TextBasic(
                    text: GeneralData.getInstance().getTokenData()?.fullName ?? '-',
                    color: R.themeColor.secondaryHover,
                    fontFamily: R.fonts.displayBold,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                R.drawable.svg.iconChat,
                colorFilter: ColorFilter.mode(R.themeColor.secondary, BlendMode.srcIn),
                width: 26,
              ),
            ),
            const SizedBox(width: 10),
            // IconButton(
            //   onPressed: () {},
            //   icon: SvgPicture.asset(
            //     R.drawable.svg.iconDate,
            //     colorFilter: ColorFilter.mode(R.themeColor.secondary, BlendMode.srcIn),
            //     width: 26.0,
            //   ),
            // ),
            // const SizedBox(width: 10.0),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                R.drawable.svg.iconNotification,
                colorFilter: ColorFilter.mode(R.themeColor.secondary, BlendMode.srcIn),
                width: 26,
              ),
            ),
          ],
        ),
      );

  Widget _getBody(BuildContext context, VmPublicListing viewModel) => ScrollWithNoGlowWidget(
        child: Container(),
      );
}
