import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repo/auth_repo.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;
  RegisterCubit(this.authRepo) : super(const RegisterState.initial());

  Future register({required String email, required String password, required String name}) async {
    emit(const RegisterState.registering());
    final result = await authRepo.register(email: email, password: password, name: name);
    result.when(
      error: (failure) => emit(RegisterState.registerError(failure)),
      success: (_) => emit(const RegisterState.registerSuccess()),
    );
  }
}
