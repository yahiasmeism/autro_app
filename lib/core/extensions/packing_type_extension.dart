import '../constants/enums.dart';

extension PackingTypeX on PackingType {
  String get str {
    switch (this) {
      case PackingType.bales:
        return 'Bales';
      case PackingType.loose:
        return 'Loose';
      case PackingType.bulks:
        return 'Bulks';
      case PackingType.rolls:
        return 'Rolls';
      case PackingType.packing:
        return 'Packing';
      case PackingType.lots:
        return 'Lots';
      default:
        return 'Unknown';
    }
  }

  static PackingType fromString(String value) {
    switch (value) {
      case 'bales':
        return PackingType.bales;
      case 'loose':
        return PackingType.loose;
      case 'bulks':
        return PackingType.bulks;
      case 'rolls':
        return PackingType.rolls;
      case 'packing':
        return PackingType.packing;
      case 'lots':
        return PackingType.lots;
      default:
        return PackingType.unknown;
    }
  }
}
