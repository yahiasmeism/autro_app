import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/deals/domin/entities/deal_bill_entity.dart';
import 'package:autro_app/features/deals/domin/use_cases/create_deal_bill_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/deals_bills_repository.dart';

@lazySingleton
class UpdateDealBillUseCase extends UseCase<DealBillEntity, UpdateDealBillUseCaseParams> {
  final DealsBillsRepository repository;

  UpdateDealBillUseCase({required this.repository});
  @override
  Future<Either<Failure, DealBillEntity>> call(UpdateDealBillUseCaseParams params) async {
    return await repository.updateDealBill(params);
  }
}

class UpdateDealBillUseCaseParams extends CreateDealBillUseCaseParams {
  final int id;
  final bool deleteAttachemnt;
  const UpdateDealBillUseCaseParams({
    required this.id,
    required super.number,
    required super.vendor,
    required super.amount,
    required super.notes,
    required super.date,
    required this.deleteAttachemnt,
    required super.attachmentPath,
  });

  @override
  List<Object?> get props => [
        number,
        vendor,
        amount,
        notes,
        date,
        attachmentPath,
        deleteAttachemnt,
      ];
}
