import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/customers/data/models/customer_model.dart';
import 'package:autro_app/features/customers/domin/usecases/update_customer_usecase.dart';

class UpdateCustomerRequest extends RequestMapable {
  final CustomerModel customerModel;

  UpdateCustomerRequest({required this.customerModel});

  factory UpdateCustomerRequest.fromParams(UpdateCustomerUsecaseParams params) {
    return UpdateCustomerRequest(
      customerModel: CustomerModel.fromEntity(params.customerEntity),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": customerModel.name,
      "country": customerModel.country,
      "city": customerModel.city,
      "website": customerModel.website,
      "business_details": customerModel.businessDetails,
      "email": customerModel.email,
      "phone": customerModel.phone,
      "alt_phone": customerModel.altPhone,
      "primary_contact": customerModel.primaryContact,
      "notes": customerModel.notes
    };
  }
}
