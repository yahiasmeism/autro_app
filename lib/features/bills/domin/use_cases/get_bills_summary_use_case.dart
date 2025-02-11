import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/bills/domin/entities/bills_summary_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../dtos/bill_filter_dto.dart';
import '../repostiries/bills_respository.dart';

@lazySingleton
class GetBillsSummaryUseCase extends UseCase<BillsSummaryEntity, GetBillsSummaryUseCaseParams> {
  final BillsRepository repository;

  GetBillsSummaryUseCase({required this.repository});
  @override
  Future<Either<Failure, BillsSummaryEntity>> call(GetBillsSummaryUseCaseParams params) async {
    return await repository.getBillsSummary(params);
  }
}

class GetBillsSummaryUseCaseParams extends Equatable {
  final BillsFilterDto? filterDto;

  const GetBillsSummaryUseCaseParams({required this.filterDto});
  @override
  List<Object?> get props => [filterDto];
}
