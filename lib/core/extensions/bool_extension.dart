extension BoolX on bool? {
  bool get orFalse => this ?? false;
  bool get isTrue => this != null && this!;
  bool get isFalse => this != null && !this!;
  bool get isFalseOrNull => !isTrue;
}
