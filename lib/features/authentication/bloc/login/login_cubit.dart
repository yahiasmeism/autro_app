import 'package:autro_app/features/authentication/bloc/app_auth/app_auth_bloc.dart';
import 'package:autro_app/features/authentication/bloc/login/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repo/auth_repo.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AppAuthBloc appAuthBloc;
  final AuthRepo authRepo;
  LoginCubit(this.authRepo, this.appAuthBloc) : super(const LoginInitial());

  Future login({required String email, required String password}) async {
    emit(const LoginInProgress());
    final either = await authRepo.login(email: email, password: password);

    either.fold(
      (l) => emit(LoginError(failure: l)),
      (r) {
        appAuthBloc.add(AuthenticatedAppEvent(user: r));
        emit(const LoginCompleted());
      },
    );
  }
}
