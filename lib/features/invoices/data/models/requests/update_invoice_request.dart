import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/invoices/data/models/requests/invoice_good_description_request.dart';

import '../../../domin/use_cases/update_invoice_use_case.dart';

class UpdateInvoiceRequest extends UpdateInvoiceUseCaseParams implements RequestMapable {
  const UpdateInvoiceRequest({
    required super.id,
    required super.invoiceNumber,
    required super.date,
    required super.customerId,
    required super.taxId,
    required super.proformaId,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
  });

  factory UpdateInvoiceRequest.fromParams(UpdateInvoiceUseCaseParams params) => UpdateInvoiceRequest(
        invoiceNumber: params.invoiceNumber,
        proformaId: params.proformaId,
        id: params.id,
        date: params.date,
        customerId: params.customerId,
        taxId: params.taxId,
        bankAccountId: params.bankAccountId,
        notes: params.notes,
        descriptions: params.descriptions,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "invoice_number": invoiceNumber,
      "date": date,
      "customer_id": customerId,
      "tax_id": taxId,
      "proforma_id": proformaId,
      "bank_account_id": bankAccountId,
      "notes": notes,
      "goods_descriptions": descriptions.map((e) => InvoiceGoodDescriptionRequest.fromParams(e).toJson()).toList(),
    };
  }
}
