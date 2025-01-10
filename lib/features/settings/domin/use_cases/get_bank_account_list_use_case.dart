import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/settings_repository.dart';

@lazySingleton
class GetBankAccountListUseCase extends UseCase<List<BankAccountEntity>, NoParams> {
  final SettingsRepository repository;

  GetBankAccountListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<BankAccountEntity>>> call(NoParams params) async {
    return await repository.getBankAccountsList();
  }
}
