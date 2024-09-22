import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/resources/_r.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';

class WidgetWebFooter extends WidgetBase<VmWidgetWebFooter> {
  const WidgetWebFooter({
    super.key,
    super.isActiveLoadingIndicator = false,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetWebFooter createViewModel(BuildContext context) => VmWidgetWebFooter();

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetWebFooter viewModel) => Container(
        margin: EdgeInsets.only(
          bottom: size(context).width * 0.01,
          left: size(context).width * 0.06,
          right: size(context).width * 0.06,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: R.themeColor.boxBg,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            SvgPicture.asset(R.drawable.svg.logo),
            Expanded(flex: 2, child: Container()),
            IconButton(onPressed: () {}, icon: SvgPicture.asset(R.drawable.svg.iconFacebook)),
            IconButton(onPressed: () {}, icon: SvgPicture.asset(R.drawable.svg.iconInstagram)),
            IconButton(onPressed: () {}, icon: SvgPicture.asset(R.drawable.svg.iconLinkedn)),
            IconButton(onPressed: () {}, icon: SvgPicture.asset(R.drawable.svg.iconTwitter)),
            IconButton(onPressed: () {}, icon: SvgPicture.asset(R.drawable.svg.iconYoutube)),
          ],
        ),
      );

  @override
  Widget buildWidget(BuildContext context, VmWidgetWebFooter viewModel) => const SizedBox.shrink();
}

class VmWidgetWebFooter extends ViewModelBase {
  VmWidgetWebFooter() {
    init();
  }
  @override
  void init() {}
}
