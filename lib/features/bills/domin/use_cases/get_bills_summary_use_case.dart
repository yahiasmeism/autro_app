import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/bills/domin/entities/bills_summary_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repostiries/bills_respository.dart';

@lazySingleton
class GetBillsSummaryUseCase extends UseCase<BillsSummaryEntity, NoParams> {
  final BillsRepository repository;

  GetBillsSummaryUseCase({required this.repository});
  @override
  Future<Either<Failure, BillsSummaryEntity>> call(NoParams params) async {
    return await repository.getBillsSummary();
  }
}
