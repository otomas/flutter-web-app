import 'package:flutter/material.dart';

import '../../core/enums/enum_api.dart';
import '../../core/extensions/extension_payment_type.dart';
import '../../core/models/model_payment_type.dart';
import '../../core/models/model_value.dart';
import '../../core/resources/_r.dart';
import '../../core/utils/formatters.dart';
import 'widget_dropdown.dart';
import 'widget_textfield.dart';

class WidgetPaymentCard extends StatelessWidget {
  const WidgetPaymentCard({
    required this.paymentTypes,
    required this.onChangedPaymentType,
    required this.onChangedAccountType,
    required this.onPressedRemove,
    required this.selectedPaymentType,
    super.key,
  });
  final List<ModelPaymentType> paymentTypes;
  final Function(ModelPaymentType? paymentType, bool isAutoComplete) onChangedPaymentType;
  final Function(ModelValue? accountType, bool isAutoComplete) onChangedAccountType;
  final Function() onPressedRemove;

  final ModelPaymentType selectedPaymentType;

  @override
  Widget build(BuildContext context) {
    final paymentType = PaymentType.fromId(selectedPaymentType.id);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: paymentType.getBgColor(),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownBasic(
                  title: 'Ödeme Tipi',
                  items: paymentTypes,
                  selectedItem: selectedPaymentType,
                  onChanged: onChangedPaymentType,
                ),
              ),
              if (selectedPaymentType.items == null) _getAmountField(context),
            ],
          ),
          const SizedBox(height: 10),
          if (selectedPaymentType.items != null)
            Row(
              children: [
                Expanded(
                  child: DropdownBasic(
                    key: UniqueKey(),
                    title: 'Hesap',
                    selectedItem: selectedPaymentType.selectedItem,
                    items: selectedPaymentType.items,
                    onChanged: onChangedAccountType,
                  ),
                ),
                _getAmountField(context),
              ],
            ),
        ],
      ),
    );
  }

  Widget _getAmountField(BuildContext context) => Expanded(
        child: Row(
          children: [
            Expanded(
              child: TextFieldBasic(
                title: 'Tutar',
                hintText: '00.00',
                keyboardType: TextInputType.number,
                labelTextColor: R.color.candy,
                labelTextFont: R.fonts.displayBold,
                controller: selectedPaymentType.amountController,
                fontFamily: R.fonts.displayBold,
                textColor: R.color.candy,
                textAlign: TextAlign.end,
                titleAlign: TextAlign.end,
                inputFormatters: [DecimalFormatter()],
              ),
            ),
            GestureDetector(
              onTap: onPressedRemove,
              child: Container(
                height: 24,
                width: 24,
                margin: const EdgeInsets.only(top: 20, left: 4),
                decoration: BoxDecoration(
                  color: R.color.candy,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove, color: R.color.white, size: 16),
              ),
            ),
          ],
        ),
      );
}
