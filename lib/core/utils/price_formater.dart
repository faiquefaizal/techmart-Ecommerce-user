import 'package:intl/intl.dart';

String formatIndianPrice(num amount) {
  final format = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );
  return format.format(amount);
}

extension FancyDateFormat on DateTime {
  String toFancyFormat() {
    final day = this.day;
    final suffix = _getDaySuffix(day);
    final month = _monthAbbreviation(this.month);
    final year = this.year;

    return '$day$suffix $month $year';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String _monthAbbreviation(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
