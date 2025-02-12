import 'package:autro_app/features/invoices/domin/dtos/invoice_good_description_dto.dart';

class InvoicePdfDto {
  final String bankAccountNumber;
  final String bankName;
  final String swiftCode;
  final String invoiceNumber;
  final DateTime date;
  final String customerName;
  final String customerAddress;
  final String taxId;
  final String notes;
  final String dealSeriesNumber;
  final String currency;
  final List<InvoiceGoodDescriptionDto> descriptions;

  InvoicePdfDto({
    required this.invoiceNumber,
    required this.customerAddress,
    required this.bankAccountNumber,
    required this.swiftCode,
    required this.date,
    required this.customerName,
    required this.taxId,
    required this.bankName,
    required this.notes,
    required this.dealSeriesNumber,
    required this.descriptions,
    required this.currency,
  });

  double get totalWeight => descriptions.fold<double>(
        0,
        (previousValue, element) => previousValue + element.weight,
      );

  double get totalAmount => descriptions.fold<double>(
        0,
        (previousValue, element) => previousValue + (element.unitPrice * element.weight),
      );
}
