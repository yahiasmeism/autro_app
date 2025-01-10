import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:autro_app/features/settings/domin/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class AddBankAccountUseCase extends UseCase<BankAccountEntity, AddBankAccountUseCaseParams> {
  final SettingsRepository settingsRepository;

  AddBankAccountUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, BankAccountEntity>> call(AddBankAccountUseCaseParams params) async {
    return await settingsRepository.addBankAccount(params);
  }
}

class AddBankAccountUseCaseParams extends Equatable {
  final String accountNumber;
  final String bankName;
  final String swiftCode;
  final String currency;

  const AddBankAccountUseCaseParams({
    required this.accountNumber,
    required this.bankName,
    required this.swiftCode,
    required this.currency,
  });

  @override
  List<Object?> get props => [
        accountNumber,
        bankName,
        swiftCode,
        currency,
      ];
}
