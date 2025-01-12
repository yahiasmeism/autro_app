import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:autro_app/features/authentication/data/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrentUserUseCase extends UseCase<UserModel, NoParams> {
  final AuthRepo authRepo;

  GetCurrentUserUseCase({required this.authRepo});

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await authRepo.getUser();
  }
}
