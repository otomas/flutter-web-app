import 'package:flutter/material.dart';
import '../../core/enums/enum_api.dart';
import '../../core/extensions/extension_payment_type.dart';
import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetCustomPaymentTypeByNumber extends StatelessWidget {
  const WidgetCustomPaymentTypeByNumber({required this.paymentType, required this.isBs, super.key});
  
  final PaymentType paymentType;
  final bool isBs;

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(color: paymentType.getBgColor(), borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.only(left: 6, top: 4, right: 6, bottom: 4),
      height: 30,
      alignment: Alignment.center,
      child: TextBasic(
        text: paymentType.getTitle(),
        color: paymentType.getTitleColor(),
        fontSize: 12,
        fontFamily: R.fonts.displayMedium,
      ),
    );
}
