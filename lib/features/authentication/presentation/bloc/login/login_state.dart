part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.loginLoading() = LoggingIn;
  const factory LoginState.loginSuccess() = LoginSuccess;
  const factory LoginState.loginError(Failure failure) = LoginError;
}
