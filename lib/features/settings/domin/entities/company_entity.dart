import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String name;
  final String address;
  final String phone;
  final String telephone;
  final String email;
  final String website;
  final String logoUrl;
  final String signatureUrl;
  final String vat;

  const CompanyEntity({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.telephone,
    required this.website,
    required this.logoUrl,
    required this.signatureUrl,
    required this.vat,
  });

  @override
  List<Object?> get props => [
        name,
        address,
        phone,
        email,
        website,
        logoUrl,
        signatureUrl,
        telephone,
        vat,
      ];
}
