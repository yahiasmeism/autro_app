import 'package:autro_app/core/constants/enums.dart';

extension PrimaryContactTypeX on PrimaryContectType {
  String get str {
    switch (this) {
      case PrimaryContectType.email:
        return 'Email';
      case PrimaryContectType.phone:
        return 'Phone';
      default:
        return 'Unknown';
    }
  }

  static PrimaryContectType fromString(String? name) {
    switch (name?.toLowerCase()) {
      case 'email':
        return PrimaryContectType.email;
      case 'phone':
        return PrimaryContectType.phone;
      default:
        return PrimaryContectType.unknown;
    }
  }
}
