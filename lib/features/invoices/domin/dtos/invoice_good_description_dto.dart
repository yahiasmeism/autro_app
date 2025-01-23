import '../entities/invoice_goods_description_entity.dart';
import '../use_cases/create_invoice_use_case.dart';

class InvoiceGoodDescriptionDto extends InvoiceGoodDescriptionParams {
  final String uniqueKey;
  const InvoiceGoodDescriptionDto({
    required super.description,
    required this.uniqueKey,
    required super.weight,
    required super.unitPrice,
    required super.containerNumber,
  });

  @override
  List<Object?> get props => [description, uniqueKey, weight, unitPrice, containerNumber];

  InvoiceGoodDescriptionDto copyWith({
    String? description,
    String? uniqueKey,
    int? containersCount,
    double? weight,
    double? unitPrice,
    String? containerNumber,
  }) {
    return InvoiceGoodDescriptionDto(
      description: description ?? this.description,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      weight: weight ?? this.weight,
      unitPrice: unitPrice ?? this.unitPrice,
      containerNumber: containerNumber ?? this.containerNumber,
    );
  }

  double get totalPrice => weight * unitPrice;

  factory InvoiceGoodDescriptionDto.fromEntity(InvoiceGoodsDescriptionEntity entity) => InvoiceGoodDescriptionDto(
        description: entity.description,
        uniqueKey: entity.id.toString(),
        weight: entity.weight,
        unitPrice: entity.unitPrice,
        containerNumber: entity.containerNumber,
      );
}
