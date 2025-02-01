import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:equatable/equatable.dart';

class ShippingInvoiceEntity extends Equatable {
  final int id;
  final int dealId;
  final String shippingCompanyName;
  final double shippingCost;
  final String typeMaterialName;
  final String currency;
  final DateTime shippingDate;
  final String attachmentUrl;
  final CustomerInvoiceEntity invoice;

  const ShippingInvoiceEntity({
    required this.id,
    required this.dealId,
    required this.shippingCompanyName,
    required this.shippingCost,
    required this.attachmentUrl,
    required this.typeMaterialName,
    required this.currency,
    required this.shippingDate,
    required this.invoice,
  });

  String get formattedDealSeriesNumber => '#Deal${dealId.toString().padLeft(4, '0')}';
  @override
  List<Object?> get props => [
        id,
        dealId,
        shippingCompanyName,
        shippingCost,
        attachmentUrl,
        typeMaterialName,
        currency,
        shippingDate,
        invoice,
      ];

  String get currencySymbol {
    switch (currency) {
      case 'EUR':
        return '€';
      case 'USD':
        return '\$';
      default:
        return '';
    }
  }

  bool get hasAttachment => attachmentUrl.isNotEmpty;

  bool get hasImageAttachment =>
      attachmentUrl.split('.').last == 'jpg' || attachmentUrl.split('.').last == 'png' || attachmentUrl.split('.').last == 'jpeg';

  bool get hasPdfAttachment => attachmentUrl.split('.').last == 'pdf';
}
