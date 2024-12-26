extension NumX on num? {
  int get toIntOrZero => this?.toInt() ?? 0;

  double get toDoubleOrZero => this?.toDouble() ?? 0;
}
