import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/bills/domin/entities/bill_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repostiries/bills_respository.dart';

@lazySingleton
class UpdateBillUseCase extends UseCase<BillEntity, UpdateBillUseCaseParams> {
  final BillsRepository repository;

  UpdateBillUseCase({required this.repository});

  @override
  Future<Either<Failure, BillEntity>> call(UpdateBillUseCaseParams params) async {
    return await repository.updateBill(params);
  }
}

class UpdateBillUseCaseParams extends Equatable {
  final int id;
  final String vendor;
  final double amount;
  final String notes;
  final DateTime date;

  const UpdateBillUseCaseParams({
    required this.id,
    required this.vendor,
    required this.amount,
    required this.notes,
    required this.date,
  });

  @override
  List<Object?> get props => [id, vendor, amount, notes, date];
}


/* 
    "vendor":"green energy",
    "amount":2342.2,
    "notes":"notes",
    "date":"2024-02-02"
 */