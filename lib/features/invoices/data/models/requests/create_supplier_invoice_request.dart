import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/invoices/domin/use_cases/create_supplier_invoice_use_case.dart';
import 'package:dio/dio.dart';

class CreateSupplierInvoiceRequest extends CreateSupplierInvoiceUseCaseParams implements RequestMapable {
  const CreateSupplierInvoiceRequest({
    required super.dealId,
    required super.supplierId,
    required super.material,
    required super.totalAmount,
    required super.date,
    required super.attachementPath,
    required super.status,
  });

  factory CreateSupplierInvoiceRequest.fromParams(CreateSupplierInvoiceUseCaseParams params) {
    return CreateSupplierInvoiceRequest(
      dealId: params.dealId,
      supplierId: params.supplierId,
      material: params.material,
      totalAmount: params.totalAmount,
      date: params.date,
      attachementPath: params.attachementPath,
      status: params.status,
    );
  }

  Future<FormData> toFormDate() async {
    return FormData.fromMap({
      ...toJson(),
      'attachment': attachementPath != null ? await MultipartFile.fromFile(attachementPath!) : null,
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'deal_id': dealId,
      'supplier_id': supplierId,
      'material': material,
      'total_amount': totalAmount,
      "date": date.formattedDateYYYYMMDD,
      "status": status.toLowerCase(),
    };
  }
}
