import 'package:autro_app/features/invoices/domin/entities/invoice_entity.dart';
import 'package:autro_app/features/proformas/domin/entities/proforma_entity.dart';
import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entites.dart';
import 'package:equatable/equatable.dart';

class DealEntity extends Equatable {
  final int id;
  final int customerProformaId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String notes;
  final bool isComplete;
  final DateTime shippingDate;
  final DateTime? deliveryDate;
  final DateTime etaDate;
  final String seriesNumber;
  final ProformaEntity customerProforma;
  final InvoiceEntity? customerInvoice;
  final ShippingInvoiceEntity? shippingInvoice;

  const DealEntity({
    required this.id,
    required this.customerProformaId,
    required this.createdAt,
    required this.updatedAt,
    required this.notes,
    required this.isComplete,
    required this.shippingDate,
    required this.deliveryDate,
    required this.etaDate,
    required this.seriesNumber,
    required this.customerProforma,
    required this.customerInvoice,
    required this.shippingInvoice,
  });

  bool get hasInvoice => customerInvoice != null;
  bool get hasShippingInvoice => shippingInvoice != null;

  @override
  List<Object?> get props => [
        id,
        customerProformaId,
        createdAt,
        updatedAt,
        notes,
        isComplete,
        shippingDate,
        deliveryDate,
        etaDate,
        seriesNumber,
        customerProforma,
        customerInvoice,
        shippingInvoice,
      ];
}

// {
//     "id": 3,
//     "customer_proforma_id": 4,
//     "created_at": "2025-01-28T21:08:30.000000Z",
//     "updated_at": "2025-01-28T21:08:30.000000Z",
//     "notes": "notes",
//     "is_complete": false,
//     "shipping_date": "2025-01-01T00:00:00.000000Z",
//     "delivery_date": null,
//     "eta_date": "2025-02-02T00:00:00.000000Z",
//     "series_number": "0003",
//     "customer_proforma": null,
//     "customer_invoice": null,
//     "shipping_invoice": null,
// }