import 'package:flutter/material.dart';

import '../enums/enum_api.dart';
import '../resources/_r.dart';

extension ExtensionPaymentType on PaymentType {
  Color getBgColor() {
    switch (this) {
      case PaymentType.cash:
        return R.themeColor.successLight;
      case PaymentType.bankTransfer:
        return R.themeColor.warningLight;
      case PaymentType.creditCard:
        return R.themeColor.primaryLight;
      case PaymentType.prepaidCard:
        return R.themeColor.primaryLight;
    }
  }

  Color getTitleColor() {
    switch (this) {
      case PaymentType.cash:
        return R.themeColor.success;
      case PaymentType.bankTransfer:
        return R.themeColor.warning;
      case PaymentType.creditCard:
        return R.themeColor.primary;
      case PaymentType.prepaidCard:
        return R.themeColor.primary;
    }
  }

  String getTitle() {
    switch (this) {
      case PaymentType.cash:
        return 'Nakit';
      case PaymentType.bankTransfer:
        return'Banka Transferi';
      case PaymentType.creditCard:
        return 'Kredi Kartı';
      case PaymentType.prepaidCard:
        return 'Ön Ödemeli Kart';
    }
  }
}
