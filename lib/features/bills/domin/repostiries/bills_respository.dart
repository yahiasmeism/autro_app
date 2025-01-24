import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/bill_entity.dart';
import '../use_cases/add_bill_use_case.dart';
import '../use_cases/get_bills_list_use_case.dart';
import '../use_cases/update_bill_use_case.dart';

abstract class BillsRepository {
  Future<Either<Failure, List<BillEntity>>> getBillsList(GetBillsListUseCaseParams params);

  Future<Either<Failure, BillEntity>> addBill(AddBillUseCaseParams params);

  Future<Either<Failure, Unit>> deleteBill(int billId);

  Future<Either<Failure, BillEntity>> updateBill(UpdateBillUseCaseParams params);

  Future<Either<Failure, BillEntity>> getBill(int billId);
}
