import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/invoice_settings_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/settings_repository.dart';

@lazySingleton
class GetInvoiceSettingsUseCase extends UseCase<InvoiceSettingsEntity, NoParams> {
  final SettingsRepository settingsRepository;

  GetInvoiceSettingsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, InvoiceSettingsEntity>> call(NoParams params) {
    return settingsRepository.getInvoiceSettings();
  }
}
