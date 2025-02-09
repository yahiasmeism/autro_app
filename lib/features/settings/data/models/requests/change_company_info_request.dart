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
    required super.deleteLogo,
    required super.deleteSignature,
    required super.vat,
    super.logoPath,
    super.signaturePath,
  });

  factory ChangeCompanyInfoRequest.fromParams(ChangeCompanyInfoUseCaseParams params) {
    return ChangeCompanyInfoRequest(
      name: params.name,
      address: params.address,
      phone: params.phone,
      email: params.email,
      website: params.website,
      telephone: params.telephone,
      logoPath: params.logoPath,
      signaturePath: params.signaturePath,
      deleteLogo: params.deleteLogo,
      deleteSignature: params.deleteSignature,
      vat: params.vat,
    );
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'telephone': telephone,
      'delete_logo': deleteLogo,
      'delete_signature': deleteSignature,
      'logo': logoPath != null ? await MultipartFile.fromFile(logoPath!) : null,
      'signature': signaturePath != null ? await MultipartFile.fromFile(signaturePath!) : null,
      'vat': vat,
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
