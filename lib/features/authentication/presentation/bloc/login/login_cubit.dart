import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repo/auth_repo.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit(this.authRepo) : super(const LoginState.initial());

  Future login({required String email, required String password}) async {
    emit(const LoginState.loginLoading());
    final result = await authRepo.login(email: email, password: password);
    result.when(
      error: (error) => emit(LoginState.loginError(error)),
      success: (_) => emit(const LoginState.loginSuccess()),
    );
  }
}
