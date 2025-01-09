import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/features/settings/domin/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  const CompanyModel({
    required super.name,
    required super.address,
    required super.phone,
    required super.email,
    required super.website,
    required super.logoUrl,
    required super.signatureUrl,
    required super.telephone,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: (json['name'] as String?).orEmpty,
      address: (json['address'] as String?).orEmpty,
      phone: (json['phone'] as String?).orEmpty,
      email: (json['email'] as String?).orEmpty,
      telephone: (json['telephone'] as String?).orEmpty,
      website: (json['website'] as String?).orEmpty,
      logoUrl: (json['logo_url'] as String?).orEmpty,
      signatureUrl: (json['signature_url'] as String?).orEmpty,
    );
  }
}
