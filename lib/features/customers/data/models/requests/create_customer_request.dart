import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/customers/domin/usecases/create_customer_usecase.dart';

class CreateCustomerRequest extends RequestMapable {
  final String name;
  final String country;
  final String city;
  final String website;
  final String businessDetails;
  final String email;
  final String phone;
  final String altPhone;
  final PrimaryContectType primaryContactType;
  final String notes;

  CreateCustomerRequest(
      {required this.name,
      required this.country,
      required this.city,
      required this.website,
      required this.businessDetails,
      required this.email,
      required this.phone,
      required this.altPhone,
      required this.primaryContactType,
      required this.notes});

  factory CreateCustomerRequest.fromParams(CreateCustomerUsecaseParams params) {
    return CreateCustomerRequest(
      name: params.name,
      country: params.country,
      city: params.city,
      website: params.website,
      businessDetails: params.businessDetails,
      email: params.email,
      phone: params.phone,
      altPhone: params.altPhone,
      primaryContactType: params.primaryContactType,
      notes: params.notes,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "country": country,
      "business_details": businessDetails,
      "email": email,
      "phone": phone,
      "primary_contact": primaryContactType.name,
      if (website.isNotEmpty) "website": website,
      if (city.isNotEmpty) "city": city,
      if (altPhone.isNotEmpty) "alt_phone": altPhone,
      if (notes.isNotEmpty) "notes": notes
    };
  }
}
