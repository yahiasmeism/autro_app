import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/invoices/domin/use_cases/create_invoice_use_case.dart';

class InvoiceGoodDescriptionRequest extends InvoiceGoodDescriptionParams implements RequestMapable {
  const InvoiceGoodDescriptionRequest({
    required super.description,
    required super.containerNumber,
    required super.weight,
    required super.unitPrice,
  });

  factory InvoiceGoodDescriptionRequest.fromParams(InvoiceGoodDescriptionParams params) {
    return InvoiceGoodDescriptionRequest(
      description: params.description,
      weight: params.weight,
      unitPrice: params.unitPrice,
      containerNumber: params.containerNumber,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "container_number": containerNumber,
      "weight": weight,
      "unit_price": unitPrice,
    };
  }
}
