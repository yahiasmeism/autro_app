import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';

import 'package:autro_app/features/settings/domin/entities/company_entity.dart';

import 'package:autro_app/features/settings/domin/use_cases/change_company_info_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domin/repositories/settings_repository.dart';
import '../datasources/settings_remote_data_source.dart';
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
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }
}
