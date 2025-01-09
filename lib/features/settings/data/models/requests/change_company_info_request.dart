import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/settings/domin/use_cases/change_company_info_use_case.dart';
import 'package:dio/dio.dart';

class ChangeCompanyInfoRequest extends ChangeCompanyInfoUseCaseParams implements RequestMapable {
  const ChangeCompanyInfoRequest({
    required super.name,
    required super.address,
    required super.phone,
    required super.email,
    required super.website,
    required super.telephone,
  });

  factory ChangeCompanyInfoRequest.fromParams(ChangeCompanyInfoUseCaseParams params) {
    return ChangeCompanyInfoRequest(
      name: params.name,
      address: params.address,
      phone: params.phone,
      email: params.email,
      website: params.website,
      telephone: params.telephone,
    );
  }

  FormData toFormData() {
    return FormData.fromMap({
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'telephone': telephone,
      
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'telephone': telephone,
    };
  }
}
