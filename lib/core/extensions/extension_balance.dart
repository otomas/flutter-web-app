import 'package:intl/intl.dart';
import '../models/model_balance.dart';

extension BalanceExtension on ModelBalance? {
  String formatPrice() {
    if (this == null) {
      return '';
    }
    if (this!.amount == null) {
      return '';
    }
    return NumberFormat.currency(symbol: this!.symbol, decimalDigits: 0).format(this!.amount).replaceAll(',', '.');
  }

  String formatPriceWithoutCurrency() {
    if (this == null) {
      return '';
    }
    if (this!.amount == null) {
      return '';
    }
    final value = NumberFormat.currency(symbol: '', decimalDigits: 0).format(this!.amount).replaceAll(',', '.');
    final valueDouble = double.tryParse(value.replaceAll('.', '')) ?? 0;
    return valueDouble > 0 ? value : '';
  }

  String formatPriceWithoutCents() {
    if (this == null) {
      return '';
    }
    if (this!.amount == null) {
      return '';
    }
    final subString = NumberFormat.currency(symbol: this!.symbol)
        .format(this!.amount)
        .substring(0, NumberFormat.currency(symbol: this!.symbol).format(this!.amount).length - 3);
    return subString;
  }
}
