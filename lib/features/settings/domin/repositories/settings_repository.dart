import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/settings/domin/entities/company_entity.dart';
import 'package:autro_app/features/settings/domin/use_cases/change_company_info_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepository {
  Future<Either<Failure, CompanyEntity>> getCompany();
  Future<Either<Failure, CompanyEntity>> changeCompanyInfo(ChangeCompanyInfoUseCaseParams params);
}
