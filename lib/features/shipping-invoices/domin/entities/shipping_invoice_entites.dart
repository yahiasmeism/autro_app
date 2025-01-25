import 'package:equatable/equatable.dart';

class ShippingInvoiceEntity extends Equatable {
  final int id;
  final int invoiceId;
  final String shippingCompanyName;
  final double shippingCost;
  final String typeMaterialName;
  final String currency;
  final DateTime shippingDate;
  final String attachmentPath;

  const ShippingInvoiceEntity({
    required this.id,
    required this.invoiceId,
    required this.shippingCompanyName,
    required this.shippingCost,
    required this.attachmentPath,
    required this.typeMaterialName,
    required this.currency,
    required this.shippingDate,
  });
  @override
  List<Object?> get props => [
        id,
        invoiceId,
        shippingCompanyName,
        shippingCost,
        attachmentPath,
        typeMaterialName,
        currency,
        shippingDate,
      ];
}
