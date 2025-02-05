import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/deals/domin/repositories/deals_bills_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/deal_bill_entity.dart';
@lazySingleton
class CreateDealBillUseCase extends UseCase<DealBillEntity, CreateDealBillUseCaseParams> {
  final DealsBillsRepository dealsBillsRepository;

  CreateDealBillUseCase({required this.dealsBillsRepository});
  @override
  Future<Either<Failure, DealBillEntity>> call(CreateDealBillUseCaseParams params) async {
    return await dealsBillsRepository.createDealBill(params);
  }
}

class CreateDealBillUseCaseParams extends Equatable {
  final int dealId;
  // final String number;
  final String vendor;
  final double amount;
  final String notes;
  final DateTime date;
  final String? attachmentPath;
  const CreateDealBillUseCaseParams({
    // required this.number,
    required this.vendor,
    required this.amount,
    required this.notes,
    required this.date,
    required this.attachmentPath,
    required this.dealId,
  });

  @override
  List<Object?> get props => [
        // number,
        vendor,
        amount,
        notes,
        date,
        attachmentPath,
        dealId,
      ];
}


    // "number":"asd",
    // "vendor":"green energy",
    // "amount":10,
    // "notes":"notes",
    // "date":"2024-02-02"