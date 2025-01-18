import 'package:autro_app/core/constants/enums.dart';
import 'package:equatable/equatable.dart';

class ProformaGoodsDescriptionEntity extends Equatable {
  final int id;
  final String description;
  final int containersCount;
  final double weight;
  final double unitPrice;
  final PackingType packing;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProformaGoodsDescriptionEntity({
    required this.id,
    required this.description,
    required this.containersCount,
    required this.weight,
    required this.unitPrice,
    required this.packing,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        description,
        containersCount,
        weight,
        unitPrice,
        packing,
        createdAt,
        updatedAt,
      ];
}
