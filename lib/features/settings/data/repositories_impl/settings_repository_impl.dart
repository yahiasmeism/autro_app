import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';

import 'package:autro_app/features/settings/domin/entities/company_entity.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_bank_account_use_case.dart';

import 'package:autro_app/features/settings/domin/use_cases/change_company_info_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domin/repositories/settings_repository.dart';
import '../datasources/settings_remote_data_source.dart';
import '../models/requests/add_bank_account_request.dart';
import '../models/requests/change_company_info_request.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  final NetworkInfo networkInfo;
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl({required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, CompanyEntity>> changeCompanyInfo(ChangeCompanyInfoUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = ChangeCompanyInfoRequest.fromParams(params);
        final company = await remoteDataSource.changeCompanyInfo(body);
        return Right(company);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, CompanyEntity>> getCompany() async {
    if (await networkInfo.isConnected) {
      try {
        final company = await remoteDataSource.getCompany();
        return Right(company);
      } catch (e) {
        final error = ErrorHandler.handle(e);
        return Left(error);
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, BankAccountEntity>> addBankAccount(AddBankAccountUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = AddBankAccountRequest.fromParams(params);
        final bankAccount = await remoteDataSource.addBankAccount(body);
        return Right(bankAccount);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<BankAccountEntity>>> getBankAccountsList() async {
    if (await networkInfo.isConnected) {
      try {
        final bankAccountsList = await remoteDataSource.getBankAccountsList();
        return Right(bankAccountsList);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBankAccount(int bankAccountId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteBankAccount(bankAccountId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }
}
