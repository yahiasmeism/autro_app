import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';

import 'package:autro_app/features/invoices/domin/entities/supplier_invoice_entity.dart';

import 'package:autro_app/features/invoices/domin/use_cases/create_supplier_invoice_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/data/requests/pagination_list_request.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domin/repositories/supplier_invoices_repository.dart';
import '../../domin/use_cases/get_supplier_invoices_list_use_case.dart';
import '../../domin/use_cases/update_supplier_invoice_use_case.dart';
import '../data_sources/remote/suppliers_invoices_remote_data_source.dart';
import '../models/requests/create_supplier_invoice_request.dart';
import '../models/requests/get_suppliers_invoices_list_request.dart';
import '../models/requests/update_supplier_invoice_request.dart';

@LazySingleton(as: SupplierInvoicesRepository)
class SuppliersInvoicesRepositoryImpl extends SupplierInvoicesRepository {
  final SuppliersInvoicesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  int _totalCount = 0;
  SuppliersInvoicesRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, SupplierInvoiceEntity>> createInvoice(CreateSupplierInvoiceUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateSupplierInvoiceRequest.fromParams(params);
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
  Future<Either<Failure, SupplierInvoiceEntity>> getInvoiceById(int invoiceId) async {
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
  Future<Either<Failure, List<SupplierInvoiceEntity>>> getInvoicesList(GetSupplierInvoicesListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
      final paginationFilterBody = PaginationFilterRequest.fromDTO(params.dto);
      final body = GetSuppliersInvoicesListRequest(paginationFilterRequest: paginationFilterBody);
      final paginationList = await remoteDataSource.getInvoicesList(body);
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
  Future<Either<Failure, SupplierInvoiceEntity>> updateInvoice(UpdateSupplierInvoiceUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateSupplierInvoiceRequest.fromParams(params);
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
