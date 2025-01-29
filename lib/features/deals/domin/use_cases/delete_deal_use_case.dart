import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../repositories/deals_repository.dart';

@lazySingleton
class DeleteDealUseCase extends UseCase<Unit, int> {
  final DealsRepository dealsRepository;

  DeleteDealUseCase({required this.dealsRepository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await dealsRepository.deleteDeal(params);
  }
}
