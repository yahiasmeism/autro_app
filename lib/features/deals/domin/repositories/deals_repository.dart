import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/deals/domin/use_cases/get_deals_list_use_case.dart';
import 'package:autro_app/features/deals/domin/use_cases/update_deal_use_case.dart';
import 'package:dartz/dartz.dart';

import '../use_cases/create_deal_use_case.dart';

abstract class DealsRepository {
  Future<Either<Failure, DealEntity>> createDeal(CreateDealUseCaseParams params);
  Future<Either<Failure, List<DealEntity>>> getDealsList(GetDealsListUseCaseParams params);
  Future<Either<Failure, DealEntity>> getDealById(int dealId);
  Future<Either<Failure, DealEntity>> updateDeal(UpdateDealUseCaseParams params);
  Future<Either<Failure, Unit>> deleteDeal(int dealId);

  int get totalCount;
}
