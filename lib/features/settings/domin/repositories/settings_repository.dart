import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:autro_app/features/settings/domin/entities/company_entity.dart';
import 'package:autro_app/features/settings/domin/use_cases/change_company_info_use_case.dart';
import 'package:dartz/dartz.dart';

import '../use_cases/add_bank_account_use_case.dart';

abstract class SettingsRepository {
  Future<Either<Failure, CompanyEntity>> getCompany();
  Future<Either<Failure, CompanyEntity>> changeCompanyInfo(ChangeCompanyInfoUseCaseParams params);
  Future<Either<Failure, List<BankAccountEntity>>> getBankAccountsList();
  Future<Either<Failure, BankAccountEntity>> addBankAccount(AddBankAccountUseCaseParams params);
  Future<Either<Failure, Unit>> deleteBankAccount(int bankAccountId);
}
