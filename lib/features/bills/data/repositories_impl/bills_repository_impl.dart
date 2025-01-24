import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';
import 'package:autro_app/features/bills/data/data_sources/remote/bills_remote_data_source.dart';
import 'package:autro_app/features/bills/data/models/requests/update_bill_request.dart';
import 'package:autro_app/features/bills/domin/entities/bill_entity.dart';
import 'package:autro_app/features/bills/domin/repostiries/bills_respository.dart';
import 'package:autro_app/features/bills/domin/use_cases/add_bill_use_case.dart';
import 'package:autro_app/features/bills/domin/use_cases/get_bills_list_use_case.dart';
import 'package:autro_app/features/bills/domin/use_cases/update_bill_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../models/requests/add_bill_request.dart';
import '../models/requests/get_bills_list_request.dart';
@LazySingleton(as: BillsRepository)
class BillsRepositoryImpl implements BillsRepository {
  final BillsRemoteDataSource billsRemoteDataSource;
  final NetworkInfo networkInfo;

  BillsRepositoryImpl({required this.billsRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, BillEntity>> addBill(AddBillUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = AddBillRequest.fromParams(params);
        return Right(await billsRemoteDataSource.addBill(body));
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBill(int billId) async {
    if (await networkInfo.isConnected) {
      try {
        await billsRemoteDataSource.deleteBill(billId);
        return const Right(unit);
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, BillEntity>> getBill(int billId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await billsRemoteDataSource.getBill(billId));
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<BillEntity>>> getBillsList(GetBillsListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = GetBillsListRequest(paginationFilterDTO: params.paginationFilterDTO);
        final list = await billsRemoteDataSource.getBillsList(body);
        _billsCount = list.total;
        return Right(list.data);
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, BillEntity>> updateBill(UpdateBillUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateBillRequest.fromParams(params);
        return Right(await billsRemoteDataSource.updateBill(body));
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  int _billsCount = 0;

  @override
  int get billsCount => _billsCount;
}
