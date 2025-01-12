import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/settings_repository.dart';

@lazySingleton
class GetUsersListUseCase extends UseCase<List<UserModel>, NoParams> {
  final SettingsRepository repository;

  GetUsersListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<UserModel>>> call(params) async {
    return await repository.getUsersList();
  }
}
