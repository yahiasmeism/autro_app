import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';
import 'package:autro_app/features/shipping-invoices/data/models/requests/create_shipping_invoice_request.dart';
import 'package:autro_app/features/shipping-invoices/data/models/requests/update_shipping_invoice_request.dart';

import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entites.dart';

import 'package:autro_app/features/shipping-invoices/domin/usecases/create_shipping_invoice_use_case.dart';

import 'package:autro_app/features/shipping-invoices/domin/usecases/get_shipping_invoices_list_use_case.dart';

import 'package:autro_app/features/shipping-invoices/domin/usecases/update_shipping_invoices_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domin/repositories/shipping_invoices_repository.dart';
import '../data_sources/remote/shipping_invoices_remote_date_source.dart';
import '../models/requests/get_shipping_invoices_list_request.dart';

@LazySingleton(as: ShippingInvoicesRepository)
class ShippingInvoicesRepositoryImpl extends ShippingInvoicesRepository {
  final NetworkInfo networkInfo;
  final ShippingInvoicesRemoteDateSource remoteDataSource;
  int _totalCount = 0;
  ShippingInvoicesRepositoryImpl({required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, ShippingInvoiceEntity>> createShippingInvoice(CreateShippingInvoiceUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateShippingInvoiceRequest.fromParams(params);
        final shippingInvoice = await remoteDataSource.createShippingInvoice(body);
        return Right(shippingInvoice);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteShippingInvoice(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteShippingInvoice(id);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, ShippingInvoiceEntity>> getShippingInvoiceById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final shippingInvoice = await remoteDataSource.getShippingInvoice(id);
        return Right(shippingInvoice);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<ShippingInvoiceEntity>>> getShippingInvoicesList(
      GetShippingInvoicesListUseCaseParams params) async {
    // if (await networkInfo.isConnected) {
    try {
      final body = GetShippingInvoicesListRequest(paginationFilterDTO: params.paginationFilterDTO);
      final shippingInvoices = await remoteDataSource.getShippingInvoicesList(body);
      _totalCount = shippingInvoices.total;
      return Right(shippingInvoices.data);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
    // } else {
    //   return Left(ErrorHandler.noInternet());
    // }
  }

  @override
  int get shippingInvoicesCount => _totalCount;

  @override
  Future<Either<Failure, ShippingInvoiceEntity>> updateShippingInvoice(UpdateShippingInvoiceUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateShippingInvoiceRequest.fromParams(params);
        final shippingInvoice = await remoteDataSource.updateShippingInvoice(body);
        return Right(shippingInvoice);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }
}
