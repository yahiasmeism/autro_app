import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:dio/dio.dart';

import '../../../domin/use_cases/update_supplier_invoice_use_case.dart';

class UpdateSupplierInvoiceRequest extends UpdateSupplierInvoiceUseCaseParams implements RequestMapable {
  const UpdateSupplierInvoiceRequest({
    required super.dealId,
    required super.supplierId,
    required super.material,
    required super.totalAmount,
    required super.date,
    required super.attachementPath,
    required super.id,
    required super.deleteAttachment,
  });

  factory UpdateSupplierInvoiceRequest.fromParams(UpdateSupplierInvoiceUseCaseParams params) => UpdateSupplierInvoiceRequest(
        attachementPath: params.attachementPath,
        date: params.date,
        dealId: params.dealId,
        deleteAttachment: params.deleteAttachment,
        id: params.id,
        material: params.material,
        supplierId: params.supplierId,
        totalAmount: params.totalAmount,
      );

  Future<FormData> toFormDate() async {
    return FormData.fromMap({
      ...toJson(),
      if (attachementPath != null) 'attachment': await MultipartFile.fromFile(attachementPath!),
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'deal_id': dealId,
      'supplier_id': supplierId,
      'material': material,
      'total_amount': totalAmount,
      'date': date.formattedDateYYYYMMDD,
      'delete_attachment': deleteAttachment,
    };
  }
}
