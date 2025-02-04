import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/deals_bills_repository.dart';
@lazySingleton
class DeleteDealBillUseCase extends UseCase<Unit, int> {
  final DealsBillsRepository repository;

  DeleteDealBillUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await repository.deleteDealBill(params);
  }
}
