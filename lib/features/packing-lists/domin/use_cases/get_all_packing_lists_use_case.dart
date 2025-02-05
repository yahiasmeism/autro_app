import 'package:autro_app/core/common/domin/dto/pagination_query_payload_dto.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../reposetories/packing_lists_repository.dart';

class GetAllPackingListsUseCase extends UseCase<List<PackingListEntity>, GetAllPackingListsUseCaseParams> {
  final PackingListsRepository packingListsRepository;

  GetAllPackingListsUseCase({required this.packingListsRepository});
  @override
  Future<Either<Failure, List<PackingListEntity>>> call(GetAllPackingListsUseCaseParams params) async {
    return await packingListsRepository.getPackingLists(params);
  }
}

class GetAllPackingListsUseCaseParams extends Equatable {
  final PaginationFilterDTO paginationFilterDTO;

  const GetAllPackingListsUseCaseParams({required this.paginationFilterDTO});
  @override
  List<Object?> get props => [paginationFilterDTO];
}
