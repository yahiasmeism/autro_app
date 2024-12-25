extension StringX on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  String get orEmpty => this ?? '';

  String get hardcoded => this ?? '';
}
