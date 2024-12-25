import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../data/repo/auth_repo.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;
  RegisterCubit(this.authRepo) : super(const RegisterInitial());

  Future register({required String email, required String password, required String name}) async {
    emit(const RegistrationInProgress());
    final either = await authRepo.register(email: email, password: password, name: name);

    either.fold(
      (l) => emit(RegisterError(failure: l)),
      (r) => emit(const RegistrationCompleted()),
    );
  }
}
