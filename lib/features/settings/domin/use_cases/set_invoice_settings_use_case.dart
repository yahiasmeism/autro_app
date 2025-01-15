import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/invoice_settings_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/settings_repository.dart';

@lazySingleton
class SetInvoiceSettingsUseCase extends UseCase<InvoiceSettingsEntity, InvoiceSettingsEntity> {
  final SettingsRepository settingsRepository;

  SetInvoiceSettingsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, InvoiceSettingsEntity>> call(InvoiceSettingsEntity params) {
    return settingsRepository.setInvoiceSettingsUseCase(params);
  }
}
