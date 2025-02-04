import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/deal_bill_entity.dart';
import '../use_cases/create_deal_bill_use_case.dart';
import '../use_cases/get_deals_bills_list_use_case.dart';
import '../use_cases/update_deal_bill_use_case.dart';

abstract class DealsBillsRepository {
  Future<Either<Failure, DealBillEntity>> createDealBill(CreateDealBillUseCaseParams params);

  Future<Either<Failure, Unit>> deleteDealBill(int billId);

  Future<Either<Failure, DealBillEntity>> updateDealBill(UpdateDealBillUseCaseParams params);

  Future<Either<Failure, List<DealBillEntity>>> getDealsBillsList(GetDealsBillsListUseCaseParams params);


  int get dealsBillsCount;
}
