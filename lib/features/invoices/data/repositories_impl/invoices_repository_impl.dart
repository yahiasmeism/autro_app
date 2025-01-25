import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/invoices/data/data_sources/remote/invoices_remote_data_source.dart';

import 'package:autro_app/features/invoices/domin/entities/invoice_entity.dart';

import 'package:autro_app/features/invoices/domin/use_cases/create_invoice_use_case.dart';

import 'package:autro_app/features/invoices/domin/use_cases/get_invoices_list_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/data/requests/pagination_list_request.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domin/repositories/invoices_repository.dart';
import '../../domin/use_cases/update_invoice_use_case.dart';
import '../models/requests/create_invoice_request.dart';
import '../models/requests/get_invoices_list_request.dart';
import '../models/requests/update_invoice_request.dart';

@LazySingleton(as: InvoicesRepository)
class InvoicesRepositoryImpl extends InvoicesRepository {
  final InvoicesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  int _totalCount = 0;
  InvoicesRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, InvoiceEntity>> createInvoice(CreateInvoiceUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateInvoiceRequest.fromParams(params);
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
  Future<Either<Failure, InvoiceEntity>> getInvoiceById(int invoiceId) async {
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
  Future<Either<Failure, List<InvoiceEntity>>> getInvoicesList(GetInvoicesListUseCaseParams params) async {
    // if (await networkInfo.isConnected) {
    try {
      final paginationFilterBody = PaginationFilterRequest.fromDTO(params.dto);
      final body = GetInvoicesListRequest(paginationFilterRequest: paginationFilterBody);
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
  Future<Either<Failure, InvoiceEntity>> updateInvoice(UpdateInvoiceUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateInvoiceRequest.fromParams(params);
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
