import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/suppliers/data/models/supplier_model.dart';
import 'package:autro_app/features/suppliers/domin/usecases/update_supplier_usecase.dart';

class UpdateSupplierRequest extends RequestMapable {
  final SupplierModel supplierModel;

  UpdateSupplierRequest({required this.supplierModel});

  factory UpdateSupplierRequest.fromParams(UpdateSupplierUsecaseParams params) {
    return UpdateSupplierRequest(
      supplierModel: SupplierModel.fromEntity(params.supplierEntity),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": supplierModel.name,
      "country": supplierModel.country,
      "business_details": supplierModel.businessDetails,
      "email": supplierModel.email,
      "phone": supplierModel.phone,
      "primary_contact": supplierModel.primaryContactType.name,
      if (supplierModel.website.isNotEmpty) "website": supplierModel.website,
      if (supplierModel.city.isNotEmpty) "city": supplierModel.city,
      if (supplierModel.altPhone.isNotEmpty) "alt_phone": supplierModel.altPhone,
      if (supplierModel.notes.isNotEmpty) "notes": supplierModel.notes
    };
  }
}
