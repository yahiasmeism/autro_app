part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = RegisterInitial;

  const factory RegisterState.registering() = Registering;

  const factory RegisterState.registerSuccess() = RegisterSuccess;

  const factory RegisterState.registerError(Failure failure) = RegisterError;
}
