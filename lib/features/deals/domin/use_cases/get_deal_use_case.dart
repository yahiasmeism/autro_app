import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/deals/domin/repositories/deals_repository.dart';
import 'package:dartz/dartz.dart';

class GetDealUseCase extends UseCase<DealEntity, int> {
  final DealsRepository dealsRepository;

  GetDealUseCase({required this.dealsRepository});
  @override
  Future<Either<Failure, DealEntity>> call(int params)async {
  return await dealsRepository.getDealById(params); 
  }
}
