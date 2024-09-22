import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/resources/_r.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widget_button.dart';
import '../../widgets/widget_buy_sell_chart.dart';
import '../../widgets/widget_for_inspection_date.dart';
import '../../widgets/widget_for_insurance_date.dart';
import '../../widgets/widget_for_me_vehicle.dart';
import '../../widgets/widget_scroll.dart';
import '../../widgets/widget_till_report.dart';
import 'vm_fragment_for_me.dart';

@RoutePage()
class FragmentForMe extends StatefulWidget {
  const FragmentForMe({super.key});

  @override
  State<FragmentForMe> createState() => _FragmentForMeState();
}

class _FragmentForMeState extends WidgetBaseStatefull<FragmentForMe, VmFragmentForMe> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentForMe createViewModel(BuildContext context) => VmFragmentForMe(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentForMe viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentForMe viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmFragmentForMe viewModel) => ScrollWithNoGlowWidget(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const WidgetForMeVehicle(),
            const SizedBox(height: 50),
            const WidgetTillReport(),
            const SizedBox(height: 30),
            const IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(child: WidgetForMeInspectionDate()),
                  SizedBox(width: 10),
                  Expanded(child: WidgetForMeInsuranceDate()),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const WidgetBuySellChart(),
            const SizedBox(height: 20),
            if (isWeb(context)) IntrinsicHeight(child: Row(children: _getUtilsButtons(context, viewModel))) else ..._getUtilsButtons(context, viewModel, false),
            const SizedBox(height: 60),
          ],
        ),
      );
  List<Widget> _getUtilsButtons(BuildContext context, VmFragmentForMe viewModel, [bool isExpanded = true]) => [
        WidgetUtilsButton(
          isExpanded: isExpanded,
          color: R.themeColor.warningLight,
          title: 'Kredi Başvurusu Görüntüle',
          description: 'Finansal ihtiyaçlarınızı karşılamanıza yardımcı unmark için tasarladık.',
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        WidgetUtilsButton(
          isExpanded: isExpanded,
          color: R.themeColor.primaryLight,
          title: 'Araç Değerle',
          description: 'Saniyeler içinde aracınızı olabildiğince hızlı, güvenli bir şekilde değerini hesaplayın.',
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        WidgetUtilsButton(
          isExpanded: isExpanded,
          color: R.themeColor.infoLight,
          title: 'Ruhsat Sorgula',
          description: 'Altyapımızı kullanarak sistemimiz üzerinden Ruhsatınızı kolayca sorgulayabilirsiniz.',
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        WidgetUtilsButton(
          isExpanded: isExpanded,
          color: R.themeColor.successLight,
          title: 'Otomas Studio',
          description: 'Aracınızın fotoğraflarını yapay zeka ile stdüyoda çekilmiş gibi tekrar düzenleyin.',
          onPressed: () {},
        ),
      ];
}
