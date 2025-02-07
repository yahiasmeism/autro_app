extension StringX on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  String get orEmpty => this ?? '';

  String get hardcoded => this ?? '';

  String get capitalized {
    return this == null || this!.isEmpty ? '' : '${this![0].toUpperCase()}${this!.substring(1)}';
  }
}
