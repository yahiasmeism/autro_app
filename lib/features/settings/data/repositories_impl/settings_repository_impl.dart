import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:autro_app/features/settings/data/models/invoice_settings_model.dart';
import 'package:autro_app/features/settings/data/models/requests/add_new_user_request.dart';
import 'package:autro_app/features/settings/data/models/requests/update_bank_account_request.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';

import 'package:autro_app/features/settings/domin/entities/company_entity.dart';
import 'package:autro_app/features/settings/domin/entities/invoice_settings_entity.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_bank_account_use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_new_user_use_case.dart';

import 'package:autro_app/features/settings/domin/use_cases/change_company_info_use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/update_bank_account_use_case.dart';

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

  @override
  Future<Either<Failure, UserModel>> addUser(AddNewUserUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = AddNewUserRequest.fromParams(params);
        final user = await remoteDataSource.addUser(body);
        return Right(user);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersList() async {
    if (await networkInfo.isConnected) {
      try {
        final usersList = await remoteDataSource.getUsersList();
        return Right(usersList);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeUser(int userId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.removeUser(userId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, InvoiceSettingsEntity>> getInvoiceSettings() async {
    if (await networkInfo.isConnected) {
      try {
        final invoiceSettings = await remoteDataSource.getInvoiceSettings();
        return Right(invoiceSettings);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, InvoiceSettingsEntity>> setInvoiceSettingsUseCase(InvoiceSettingsEntity invoiceSettings) async {
    if (await networkInfo.isConnected) {
      try {
        var invoiceSettingsModel = InvoiceSettingsModel.fromEntity(invoiceSettings);
        final updatedinvoiceSettings = await remoteDataSource.setInvoiceSettings(invoiceSettingsModel);
        return Right(updatedinvoiceSettings);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, BankAccountEntity>> updateBankAccount(UpdateBankAccountUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        var body = UpdateBankAccountRequest.fromParams(params);
        final updatedAccount = await remoteDataSource.updateBankAccount(body);
        return Right(updatedAccount);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, BankAccountEntity>> getBankAccount(int bankAccountId) async {
    if (await networkInfo.isConnected) {
      try {
        final bankAccount = await remoteDataSource.getBankAccount(bankAccountId);
        return Right(bankAccount);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }
}
