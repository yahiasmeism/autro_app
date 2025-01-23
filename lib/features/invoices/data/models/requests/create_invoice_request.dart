import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/invoices/data/models/requests/invoice_good_description_request.dart';
import 'package:autro_app/features/invoices/domin/use_cases/create_invoice_use_case.dart';

class CreateInvoiceRequest extends CreateInvoiceUseCaseParams implements RequestMapable {
  const CreateInvoiceRequest({
    required super.invoiceNumber,
    required super.date,
    required super.customerId,
    required super.taxId,
    required super.proformaId,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
  });

  factory CreateInvoiceRequest.fromParams(CreateInvoiceUseCaseParams params) {
    return CreateInvoiceRequest(
      proformaId: params.proformaId,
      invoiceNumber: params.invoiceNumber,
      date: params.date,
      customerId: params.customerId,
      taxId: params.taxId,
      bankAccountId: params.bankAccountId,
      notes: params.notes,
      descriptions: params.descriptions,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "proforma_id": proformaId,
      "date": date,
      "customer_id": customerId,
      "tax_id": taxId,
      "bank_account_id": bankAccountId,
      "notes": notes,
      "goods_descriptions": descriptions.map((e) => InvoiceGoodDescriptionRequest.fromParams(e).toJson()).toList(),
    };
  }
}
