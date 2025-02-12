import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:autro_app/features/settings/domin/repositories/settings_repository.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_bank_account_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class UpdateBankAccountUseCase extends UseCase<BankAccountEntity, UpdateBankAccountUseCaseParams> {
  final SettingsRepository settingsRepository;

  UpdateBankAccountUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, BankAccountEntity>> call(UpdateBankAccountUseCaseParams params) {
    return settingsRepository.updateBankAccount(params);
  }
}

class UpdateBankAccountUseCaseParams extends AddBankAccountUseCaseParams {
  final int id;
  const UpdateBankAccountUseCaseParams({
    required super.accountNumber,
    required super.bankName,
    required super.swiftCode,
    required super.currency,
    required this.id,
  });

  @override
  List<Object?> get props => [...super.props, id];
}
