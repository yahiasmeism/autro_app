import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/company_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/settings_repository.dart';

@lazySingleton
class ChangeCompanyInfoUseCase extends UseCase<CompanyEntity, ChangeCompanyInfoUseCaseParams> {
  final SettingsRepository repository;

  ChangeCompanyInfoUseCase({required this.repository});
  @override
  Future<Either<Failure, CompanyEntity>> call(ChangeCompanyInfoUseCaseParams params) async {
    return await repository.changeCompanyInfo(params);
  }
}

class ChangeCompanyInfoUseCaseParams extends Equatable {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String vat;
  final String telephone;
  final String website;
  final bool deleteLogo;
  final bool deleteSignature;

  const ChangeCompanyInfoUseCaseParams({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.telephone,
    required this.website,
    required this.vat,
    this.logoPath,
    this.signaturePath,
    required this.deleteLogo,
    required this.deleteSignature,
  });
  final String? logoPath;
  final String? signaturePath;

  @override
  List<Object> get props => [
        name,
        address,
        phone,
        email,
        website,
        telephone,
        vat,
      ];
}
