import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:equatable/equatable.dart';

class SupplierInvoiceEntity extends Equatable {
  final int id;
  final String number;
  final int supplierId;
  final int dealId;
  final double totalAmount;
  final String attachmentUrl;
  final DateTime date;
  final String material;
  final SupplierEntity supplier;

  const SupplierInvoiceEntity({
    required this.id,
    required this.number,
    required this.supplierId,
    required this.dealId,
    required this.totalAmount,
    required this.attachmentUrl,
    required this.date,
    required this.material,
    required this.supplier,
  });

  @override
  List<Object?> get props => [
        id,
        number,
        supplierId,
        dealId,
        totalAmount,
        attachmentUrl,
        date,
        material,
        supplier,
      ];
}
