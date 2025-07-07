import 'package:intl/intl.dart';

class NumberFormatter {
  static String formatPrice(dynamic price) {
    double? parsed;

    if (price is String) {
      parsed = double.tryParse(price);
    } else if (price is num) {
      parsed = price.toDouble();
    }

    if (parsed == null) return '0';

    return NumberFormat('#,###').format(parsed.toInt());
  }
}
