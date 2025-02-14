import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/bills/domin/entities/bill_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repostiries/bills_respository.dart';

@lazySingleton
class AddBillUseCase extends UseCase<BillEntity, AddBillUseCaseParams> {
  final BillsRepository repository;

  AddBillUseCase({required this.repository});

  @override
  Future<Either<Failure, BillEntity>> call(AddBillUseCaseParams params) async {
    return await repository.addBill(params);
  }
}

class AddBillUseCaseParams extends Equatable {
  final String vendor;
  final double amount;
  final double vat;
  final String notes;
  final DateTime date;
  final String? attachmentPath;

  const AddBillUseCaseParams({
    required this.vendor,
    required this.amount,
    required this.notes,
    required this.date,
    required this.attachmentPath,
    required this.vat,
  });
  @override
  List<Object?> get props => [vendor, amount, notes, date, attachmentPath, vat];
}

/* 

    "vendor":"green energy",
    "amount":2342.2,
    "notes":"notes",
    "date":"2024-02-02"
 */