extension MapX on Map<String, dynamic>? {
  Map<String, dynamic> get orEmpty => this ?? <String, dynamic>{};
}
