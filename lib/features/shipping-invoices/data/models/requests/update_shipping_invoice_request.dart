import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/shipping-invoices/domin/usecases/update_shipping_invoices_use_case.dart';
import 'package:dio/dio.dart';

class UpdateShippingInvoiceRequest extends UpdateShippingInvoiceUseCaseParams implements RequestMapable {
  const UpdateShippingInvoiceRequest({
    required super.id,
    required super.dealId,
    required super.shippingCompanyName,
    required super.shippingCost,
    required super.typeMaterialName,
    required super.shippingDate,
    required super.deleteAttachment,
    super.attachmentPath,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      if (attachmentPath != null) 'attachment': await MultipartFile.fromFile(attachmentPath!),
    });
  }

  factory UpdateShippingInvoiceRequest.fromParams(UpdateShippingInvoiceUseCaseParams params) => UpdateShippingInvoiceRequest(
        id: params.id,
        dealId: params.dealId,
        shippingCompanyName: params.shippingCompanyName,
        shippingCost: params.shippingCost,
        typeMaterialName: params.typeMaterialName,
        shippingDate: params.shippingDate,
        attachmentPath: params.attachmentPath,
        deleteAttachment: params.deleteAttachment,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deal_id': dealId,
      'shipping_company_name': shippingCompanyName,
      'shipping_cost': shippingCost,
      'type_material_name': typeMaterialName,
      'shipping_date': shippingDate.formattedDateYYYYMMDD,
      'delete_attachment': deleteAttachment,
    };
  }
}
