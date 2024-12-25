import 'package:autro_app/features/authentication/bloc/login/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repo/auth_repo.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit(this.authRepo) : super(const LoginInitial());

  Future login({required String email, required String password}) async {
    emit(const LoginInProgress());
    final either = await authRepo.login(email: email, password: password);

    either.fold(
      (l) => emit(LoginError(failure: l)),
      (r) => emit(const LoginCompleted()),
    );
  }
}
