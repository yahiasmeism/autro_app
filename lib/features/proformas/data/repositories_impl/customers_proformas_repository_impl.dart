import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/proformas/data/data_sources/remote/customers_proformas_remote_data_source.dart';

import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';

import 'package:autro_app/features/proformas/domin/use_cases/create_customer_proforma_use_case.dart';

import 'package:autro_app/features/proformas/domin/use_cases/get_customers_proformas_list_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/data/requests/pagination_list_request.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domin/repositories/customers_proformas_repository.dart';
import '../../domin/use_cases/update_customer_proforma_use_case.dart';
import '../models/requests/create_customer_proforma_request.dart';
import '../models/requests/get_customers_proformas_list_request.dart';
import '../models/requests/update_customer_proforma_request.dart';

@LazySingleton(as: CustomersProformasRepository)
class CustomersProformasRepositoryImpl extends CustomersProformasRepository {
  final CustomersProformasRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  int _totalCount = 0;
  CustomersProformasRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, CustomerProformaEntity>> createCustomerProforma(CreateCustomerProformaUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateCustomerProformaRequest.fromParams(params);
        final customerProforma = await remoteDataSource.createCustomerProforma(body);
        return Right(customerProforma);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomerProforma(int proformaId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteCustomerProformaProforma(proformaId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, CustomerProformaEntity>> getCustomerProformaById(int proformaId) async {
    if (await networkInfo.isConnected) {
      try {
        final customerProforma = await remoteDataSource.getCustomerProformaById(proformaId);
        return Right(customerProforma);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<CustomerProformaEntity>>> getCustomersProformasList(
      GetCustomersProformasListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final paginationFilterBody = PaginationFilterRequest.fromDTO(params.dto);
        final body = GetCustomersProformasListRequest(paginationFilterRequest: paginationFilterBody);
        final paginationList = await remoteDataSource.getCustomerProformasList(body);
        _totalCount = paginationList.total;
        return Right(paginationList.data);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, CustomerProformaEntity>> updateCustomerProforma(UpdateCustomerProformaUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateCustomerProformaRequest.fromParams(params);
        final updatedProforma = await remoteDataSource.updateCustomerProforma(body);
        return Right(updatedProforma);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  int get totalCount => _totalCount;
}
