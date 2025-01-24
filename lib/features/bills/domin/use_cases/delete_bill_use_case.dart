import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repostiries/bills_respository.dart';
@lazySingleton
class DeleteBillUseCase extends UseCase<Unit,int>{
  final BillsRepository repository;

  DeleteBillUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(int params) async{
    return await repository.deleteBill(params);
  }
}