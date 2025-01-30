import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/invoices/data/data_sources/remote/customers_invoices_remote_data_source.dart';

import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';

import 'package:autro_app/features/invoices/domin/use_cases/create_customer_invoice_use_case.dart';

import 'package:autro_app/features/invoices/domin/use_cases/get_customers_invoices_list_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/data/requests/pagination_list_request.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domin/repositories/customer_invoices_repository.dart';
import '../../domin/use_cases/update_customer_invoice_use_case.dart';
import '../models/requests/create_customer_invoice_request.dart';
import '../models/requests/get_customers_invoices_list_request.dart';
import '../models/requests/update_customer_invoice_request.dart';

@LazySingleton(as: CustomerInvoicesRepository)
class CustomersInvoicesRepositoryImpl extends CustomerInvoicesRepository {
  final CustomersInvoicesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  int _totalCount = 0;
  CustomersInvoicesRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, CustomerInvoiceEntity>> createInvoice(CreateCustomerInvoiceUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateCustomerInvoiceRequest.fromParams(params);
        final invoice = await remoteDataSource.createInvoice(body);
        return Right(invoice);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteInvoice(int invoiceId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteInvoice(invoiceId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, CustomerInvoiceEntity>> getInvoiceById(int invoiceId) async {
    if (await networkInfo.isConnected) {
      try {
        final invoice = await remoteDataSource.getInvoiceById(invoiceId);
        return Right(invoice);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<CustomerInvoiceEntity>>> getInvoicesList(GetCustomersInvoicesListUseCaseParams params) async {
    // if (await networkInfo.isConnected) {
    try {
      final paginationFilterBody = PaginationFilterRequest.fromDTO(params.dto);
      final body = GetCustomersInvoicesListRequest(paginationFilterRequest: paginationFilterBody);
      final paginationList = await remoteDataSource.getInvoicesList(body);
      _totalCount = paginationList.total;
      return Right(paginationList.data);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
    // } else {
    //   return Left(ErrorHandler.noInternet());
    // }
  }

  @override
  Future<Either<Failure, CustomerInvoiceEntity>> updateInvoice(UpdateCustomerInvoiceUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateCustomerInvoiceRequest.fromParams(params);
        final updatedInvoice = await remoteDataSource.updateInvoice(body);
        return Right(updatedInvoice);
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
