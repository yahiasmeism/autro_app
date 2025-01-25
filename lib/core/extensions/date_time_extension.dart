import 'package:intl/intl.dart';

extension DateTimeX on DateTime? {
  DateTime get orDefault => this ?? DateTime.utc(1);

  bool get isDefault => this != null && this!.year == 1;

  bool isAtSameDay(DateTime other) {
    final sameDay = other.day == this?.day;
    final sameMonth = other.month == this?.month;
    final sameYear = other.year == this?.year;

    return sameDay && sameMonth && sameYear;
  }

  bool get isToday {
    final now = DateTime.now();
    return isAtSameDay(now);
  }

  bool get isTomorrow {
    final now = DateTime.now();
    return isAtSameDay(now.add(const Duration(days: 1)));
  }

  bool get isYesterday {
    final now = DateTime.now();
    return isAtSameDay(now.subtract(const Duration(days: 1)));
  }
}

extension DateOnlyX on DateTime {
  String get formattedDateYYYYMMDD => DateFormat('yyyy-MM-dd').format(this);
  String get formattedDateMMMDDY => DateFormat('MMM d, y').format(this);
}
