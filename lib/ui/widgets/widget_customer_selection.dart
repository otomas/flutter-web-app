import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/models/model_customer.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_route.dart';
import '../../ui/widgets/widget_button.dart';
import '../../ui/widgets/widget_dropdown.dart';
import '../../ui/widgets/widgets_text.dart';
import '../bs/bs_add_customer.dart';

class WidgetCustomerSelection extends StatefulWidget {
  const WidgetCustomerSelection({
    required this.title,
    required this.onChangedCustomer,
    required this.bgColor,
    this.buttonTitle,
    this.selectedItem,
    this.hasError = false,
    this.errorLabel,
    this.onRemove,
    super.key,
  });
  final String title;
  final String? buttonTitle;
  final Function(ModelCustomer?, bool isAutoComplete) onChangedCustomer;
  final ModelCustomer? selectedItem;
  final Color bgColor;
  final String? errorLabel;
  final bool hasError;
  final Function()? onRemove;

  @override
  State<WidgetCustomerSelection> createState() => _WidgetCustomerSelectionState();
}

class _WidgetCustomerSelectionState extends State<WidgetCustomerSelection> {
  var key = UniqueKey();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        color: widget.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  R.drawable.svg.iconUserCircle,
                  width: 82,
                  height: 82,
                ),
                const SizedBox(height: 5),
                TextBasic(
                  text: widget.title,
                  color: R.themeColor.smoke,
                  fontFamily: R.fonts.displayBold,
                  fontSize: 18,
                ),
                const SizedBox(height: 5),
              ],
            ),
            const SizedBox(height: 20),
            DropdownBasic(
              key: key,
              title: R.string.customers,
              onChanged: widget.onChangedCustomer,
              hint: 'Seçiniz',
              // ignore: discarded_futures
              callback: () => Provider.of<ServiceApi>(context, listen: false).client.getCustomers(),
              selectedItem: widget.selectedItem,
              onRemove: widget.onRemove,
              hasError: widget.hasError,
              errorLabel: widget.errorLabel,
            ),
            const SizedBox(height: 20),
            if (widget.buttonTitle != null)
              ButtonBasic(
                text: '+${widget.buttonTitle}',
                bgColor: R.themeColor.primaryLight,
                textColor: R.themeColor.primary,
                onPressed: () async {
                  await Provider.of<ServiceRoute>(context, listen: false).showBaseBottomSheet(context, const BsAddCustomer());
                  key = UniqueKey();
                  setState(() {});
                },
              ),
          ],
        ),
      );
}
