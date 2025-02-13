import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/invoices/data/models/requests/invoice_good_description_request.dart';

import '../../../domin/use_cases/update_customer_invoice_use_case.dart';

class UpdateCustomerInvoiceRequest extends UpdateCustomerInvoiceUseCaseParams implements RequestMapable {
  const UpdateCustomerInvoiceRequest({
    required super.id,
    required super.invoiceNumber,
    required super.date,
    required super.customerId,
    required super.taxId,
    required super.dealId,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
    required super.status,
  });

  factory UpdateCustomerInvoiceRequest.fromParams(UpdateCustomerInvoiceUseCaseParams params) => UpdateCustomerInvoiceRequest(
        invoiceNumber: params.invoiceNumber,
        dealId: params.dealId,
        id: params.id,
        date: params.date,
        customerId: params.customerId,
        taxId: params.taxId,
        bankAccountId: params.bankAccountId,
        notes: params.notes,
        descriptions: params.descriptions,
        status: params.status,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "invoice_number": invoiceNumber,
      "date": date,
      "customer_id": customerId,
      "tax_id": taxId,
      "deal_id": dealId,
      "bank_account_id": bankAccountId,
      "notes": notes,
      "goods_descriptions": descriptions.map((e) => InvoiceGoodDescriptionRequest.fromParams(e).toJson()).toList(),
      'status': status.toLowerCase(),
    };
  }
}
