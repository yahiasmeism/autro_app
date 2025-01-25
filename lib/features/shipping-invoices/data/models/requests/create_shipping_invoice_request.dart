import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/shipping-invoices/domin/usecases/create_shipping_invoice_use_case.dart';
import 'package:dio/dio.dart';

class CreateShippingInvoiceRequest extends CreateShippingInvoiceUseCaseParams implements RequestMapable {
  const CreateShippingInvoiceRequest({
    required super.invoiceId,
    required super.shippingCompanyName,
    required super.shippingCost,
    required super.typeMaterialName,
    required super.currency,
    required super.shippingDate,
    super.attachmentPath,
  });

  factory CreateShippingInvoiceRequest.fromParams(CreateShippingInvoiceUseCaseParams params) {
    return CreateShippingInvoiceRequest(
      invoiceId: params.invoiceId,
      shippingCompanyName: params.shippingCompanyName,
      shippingCost: params.shippingCost,
      typeMaterialName: params.typeMaterialName,
      currency: params.currency,
      shippingDate: params.shippingDate,
      attachmentPath: params.attachmentPath,
    );
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      if (attachmentPath != null) 'attachment': await MultipartFile.fromFile(attachmentPath!),
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'invoice_id': invoiceId,
      'shipping_company_name': shippingCompanyName,
      'shipping_cost': shippingCost,
      'type_material_name': typeMaterialName,
      'currency': currency,
      'shipping_date': shippingDate.formattedDateYYYYMMDD,
    };
  }
}
