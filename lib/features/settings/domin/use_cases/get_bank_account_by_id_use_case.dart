import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:autro_app/features/settings/domin/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetBankAccountByIdUseCase extends UseCase<BankAccountEntity, int> {
  final SettingsRepository repository;

  GetBankAccountByIdUseCase({required this.repository});
  @override
  Future<Either<Failure, BankAccountEntity>> call(int params) async {
    return repository.getBankAccount(params);
  }
}
