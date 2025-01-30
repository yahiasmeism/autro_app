import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/invoices/data/models/requests/invoice_good_description_request.dart';
import 'package:autro_app/features/invoices/domin/use_cases/create_customer_invoice_use_case.dart';

class CreateCustomerInvoiceRequest extends CreateCustomerInvoiceUseCaseParams implements RequestMapable {
  const CreateCustomerInvoiceRequest({
    required super.invoiceNumber,
    required super.date,
    required super.customerId,
    required super.taxId,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
    required super.dealId,
  });

  factory CreateCustomerInvoiceRequest.fromParams(CreateCustomerInvoiceUseCaseParams params) {
    return CreateCustomerInvoiceRequest(
      invoiceNumber: params.invoiceNumber,
      date: params.date,
      customerId: params.customerId,
      taxId: params.taxId,
      bankAccountId: params.bankAccountId,
      notes: params.notes,
      descriptions: params.descriptions,
      dealId: params.dealId,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'deal_id': dealId,
      'invoice_number': invoiceNumber,
      "date": date,
      "customer_id": customerId,
      "tax_id": taxId,
      "bank_account_id": bankAccountId,
      "notes": notes,
      "goods_descriptions": descriptions.map((e) => InvoiceGoodDescriptionRequest.fromParams(e).toJson()).toList(),
    };
  }
}
