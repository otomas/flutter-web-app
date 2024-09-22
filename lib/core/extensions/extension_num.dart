import 'package:intl/intl.dart';

extension NumExtension on num? {
  String formatPrice() {
    if (this == null) {
      return '';
    }
    return NumberFormat.currency(symbol: '', decimalDigits: 0).format(this).replaceAll(',', '.');
  }
}
