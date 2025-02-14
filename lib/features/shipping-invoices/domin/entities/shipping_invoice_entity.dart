import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:equatable/equatable.dart';

class ShippingInvoiceEntity extends Equatable {
  final int id;
  final int dealId;
  final String shippingInvoiceNumber;
  final String shippingCompanyName;
  final double shippingCost;
  final String typeMaterialName;
  final DateTime shippingDate;
  final String attachmentUrl;
  final String status;
  final CustomerInvoiceEntity invoice;

  const ShippingInvoiceEntity({
    required this.id,
    required this.dealId,
    required this.shippingCompanyName,
    required this.shippingCost,
    required this.attachmentUrl,
    required this.typeMaterialName,
    required this.shippingDate,
    required this.invoice,
    required this.shippingInvoiceNumber,
    required this.status,
  });

  String get formmatedShippingCost => "€${shippingCost.toStringAsFixed(2)}";
  @override
  List<Object?> get props => [
        id,
        dealId,
        shippingCompanyName,
        shippingCost,
        attachmentUrl,
        typeMaterialName,
        shippingDate,
        invoice,
        shippingInvoiceNumber,
        status,
      ];

  bool get hasAttachment => attachmentUrl.isNotEmpty;

  bool get hasImageAttachment =>
      attachmentUrl.split('.').last == 'jpg' || attachmentUrl.split('.').last == 'png' || attachmentUrl.split('.').last == 'jpeg';

  bool get hasPdfAttachment => attachmentUrl.split('.').last == 'pdf';
}
