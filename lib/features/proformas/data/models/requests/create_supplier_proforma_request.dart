import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/proformas/domin/use_cases/create_supplier_proforma_use_case.dart';
import 'package:dio/dio.dart';

class CreateSupplierProformaRequest extends CreateSupplierProformaUseCaseParams implements RequestMapable {
  const CreateSupplierProformaRequest({
    required super.dealId,
    required super.supplierId,
    required super.material,
    required super.totalAmount,
    required super.date,
    required super.attachementPath,
  });

  factory CreateSupplierProformaRequest.fromParams(CreateSupplierProformaUseCaseParams params) {
    return CreateSupplierProformaRequest(
      dealId: params.dealId,
      supplierId: params.supplierId,
      material: params.material,
      totalAmount: params.totalAmount,
      date: params.date,
      attachementPath: params.attachementPath,
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
    };
  }
}
