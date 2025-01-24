import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/bills/domin/entities/bill_entity.dart';
import 'package:autro_app/features/bills/domin/repostiries/bills_respository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class GetBillUseCase extends UseCase<BillEntity,int>{
  final BillsRepository repository;

  GetBillUseCase({required this.repository});
  @override
  Future<Either<Failure, BillEntity>> call(int params)async {
    return await repository.getBill(params);
  }
}