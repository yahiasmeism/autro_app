import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/settings_repository.dart';
@lazySingleton
class AddNewUserUseCase extends UseCase<UserModel, AddNewUserUseCaseParams> {
  final SettingsRepository repository;

  AddNewUserUseCase({required this.repository});
  @override
  Future<Either<Failure, UserModel>> call(AddNewUserUseCaseParams params) async {
    return await repository.addUser(params);
  }
}

class AddNewUserUseCaseParams extends Equatable {
  final String name;
  final String email;

  final String password;
  final String role;

  const AddNewUserUseCaseParams({
    required this.email,
    required this.name,
    required this.password,
    required this.role,
  });

  @override
  List<Object> get props => [email, name, password, role];
}
