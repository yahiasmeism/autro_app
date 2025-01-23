import 'package:equatable/equatable.dart';

class InvoiceGoodsDescriptionEntity extends Equatable {
  final int id;
  final String description;
  final double weight;
  final double unitPrice;
  final String containerNumber;
  final DateTime createdAt;
  final double totalPrice;
  final DateTime updatedAt;

  const InvoiceGoodsDescriptionEntity({
    required this.id,
    required this.description,
    required this.containerNumber,
    required this.weight,
    required this.unitPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
        id,
        description,
        weight,
        unitPrice,
        containerNumber,
        createdAt,
        updatedAt,
      ];
}
