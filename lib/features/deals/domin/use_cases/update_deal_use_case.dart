import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/deals/domin/repositories/deals_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateDealUseCase extends UseCase<DealEntity, UpdateDealUseCaseParams> {
  final DealsRepository repository;

  UpdateDealUseCase({required this.repository});
  @override
  Future<Either<Failure, DealEntity>> call(UpdateDealUseCaseParams params) async {
    return await repository.updateDeal(params);
  }
}

class UpdateDealUseCaseParams extends Equatable {
  final int dealId;
  final String? notes;
  final bool isComplete;
  final DateTime? shippingDate;
  final DateTime? etaDate;
  final DateTime? delivaryDate;

  const UpdateDealUseCaseParams({
    required this.dealId,
    required this.notes,
    required this.isComplete,
    required this.shippingDate,
    required this.etaDate,
    required this.delivaryDate,
  });

  @override
  List<Object?> get props => [
        notes,
        isComplete,
        shippingDate,
        etaDate,
        delivaryDate,
      ];
}
