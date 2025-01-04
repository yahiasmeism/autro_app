import 'package:autro_app/core/common/data/requests/pagination_list_request.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';
import 'package:autro_app/features/customers/data/models/requests/get_customers_list_request.dart';

import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';

import 'package:autro_app/features/customers/domin/usecases/create_customer_usecase.dart';

import 'package:autro_app/features/customers/domin/usecases/get_customers_list_usecase.dart';

import 'package:autro_app/features/customers/domin/usecases/update_customer_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domin/repositories/customers_repository.dart';
import '../datasources/customers_remote_datesourse.dart';
import '../models/requests/create_customer_request.dart';
import '../models/requests/update_customer_request.dart';

@LazySingleton(as: CustomersRepository)
class CustomersRepositoryImpl implements CustomersRepository {
  late int _totalCount;
  final CustomersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CustomersRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<CustomerEntity>>> getCustomersList(GetCustomersListUsecaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final paginationFilterBody = PaginationFilterRequest.fromDTO(params.dto);
        final body = GetCustomersListRequest(paginationFilterRequest: paginationFilterBody);
        final paginationList = await remoteDataSource.getCustomersList(body);
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
  Future<Either<Failure, CustomerEntity>> createCustomer(CreateCustomerUsecaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateCustomerRequest.fromParams(params);
        final customer = await remoteDataSource.createCustomer(body);
        return Right(customer);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomer(int customerId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteCustomer(customerId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, CustomerEntity>> getCustomer(int customerId) async {
    if (await networkInfo.isConnected) {
      try {
        final customer = await remoteDataSource.getCustomer(customerId);
        return Right(customer);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, CustomerEntity>> updateCustomer(UpdateCustomerUsecaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateCustomerRequest.fromParams(params);
        final customerModel = await remoteDataSource.updateCustomer(body);
        return Right(customerModel);
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
