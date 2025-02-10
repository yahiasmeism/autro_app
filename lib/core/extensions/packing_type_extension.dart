import '../constants/enums.dart';

extension PackingTypeX on PackingType {
  String get str {
    switch (this) {
      case PackingType.bales:
        return 'Bales';
      case PackingType.loose:
        return 'Loose';
      case PackingType.bults:
        return 'Bults';
      case PackingType.rolls:
        return 'Rolls';
      case PackingType.packing:
        return 'Packing';
      case PackingType.lot:
        return 'Lot';
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
      case 'bults':
        return PackingType.bults;
      case 'rolls':
        return PackingType.rolls;
      case 'packing':
        return PackingType.packing;
      case 'lot':
        return PackingType.lot;
      default:
        return PackingType.unknown;
    }
  }
}
