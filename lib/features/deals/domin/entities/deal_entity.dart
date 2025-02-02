import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entity.dart';
import 'package:equatable/equatable.dart';

class DealEntity extends Equatable {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String notes;
  final bool isComplete;
  final DateTime shippingDate;
  final DateTime? deliveryDate;
  final DateTime etaDate;
  final CustomerProformaEntity? customerProforma;
  final CustomerInvoiceEntity? customerInvoice;
  final ShippingInvoiceEntity? shippingInvoice;
  final double totalRevenue;
  final double totalExpenses;
  final double netProfit;

  const DealEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.notes,
    required this.isComplete,
    required this.shippingDate,
    required this.deliveryDate,
    required this.etaDate,
    required this.customerProforma,
    required this.customerInvoice,
    required this.shippingInvoice,
    required this.totalRevenue,
    required this.totalExpenses,
    required this.netProfit,
  });

  bool get hasInvoice => customerInvoice != null;
  bool get hasShippingInvoice => shippingInvoice != null;

  String get formattedSeriesNumber => "Deal: ${id.toString().padLeft(4, '0')}";
  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        notes,
        isComplete,
        shippingDate,
        deliveryDate,
        etaDate,
        customerProforma,
        customerInvoice,
        shippingInvoice,
        totalRevenue,
        totalExpenses,
        netProfit,
      ];
}
