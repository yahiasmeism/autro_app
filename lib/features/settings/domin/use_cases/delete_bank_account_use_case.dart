import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteBankAccountUseCase extends UseCase<Unit, int>{
  final SettingsRepository settingsRepository;

  DeleteBankAccountUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, Unit>> call(int params) async{
    return await settingsRepository.deleteBankAccount(params);
  }
}