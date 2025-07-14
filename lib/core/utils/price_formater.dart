import 'package:intl/intl.dart';

String formatIndianPrice(int amount) {
  final format = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );
  return format.format(amount);
}
