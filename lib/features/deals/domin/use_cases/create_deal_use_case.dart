import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/deals_repository.dart';

@lazySingleton
class CreateDealUseCase extends UseCase<DealEntity, CreateDealUseCaseParams> {
  final DealsRepository repository;

  CreateDealUseCase({required this.repository});
  @override
  Future<Either<Failure, DealEntity>> call(CreateDealUseCaseParams params) async {
    return await repository.createDeal(params);
  }
}

class CreateDealUseCaseParams extends Equatable {
  final int customerProformaId;

  const CreateDealUseCaseParams({required this.customerProformaId});

  @override
  List<Object?> get props => [customerProformaId];
}

