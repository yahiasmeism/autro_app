import '../constants/enums.dart';

extension ClientTypeX on ClientType {
  static ClientType fromName(String name) {
    switch (name.toLowerCase()) {
      case 'customer':
        return ClientType.customer;
      case 'supplier':
        return ClientType.supplier;
      default:
        return ClientType.unknown;
    }
  }
}
