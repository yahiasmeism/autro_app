import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/company_entity.dart';
import 'package:autro_app/features/settings/domin/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class GetCompanyUseCase extends UseCase<CompanyEntity, NoParams> {
  final SettingsRepository repository;

  GetCompanyUseCase({required this.repository});

  @override
  Future<Either<Failure, CompanyEntity>> call(NoParams params) async {
    return await repository.getCompany();
  }
}
