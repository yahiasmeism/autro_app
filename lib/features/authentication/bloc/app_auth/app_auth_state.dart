part of 'app_auth_bloc.dart';

abstract class AppAuthState extends Equatable {
  const AppAuthState();

  @override
  List<Object?> get props => [];
}

class InitialAppAuthState extends AppAuthState {
  const InitialAppAuthState();
}

class UnAuthenticatedState extends AppAuthState {
  const UnAuthenticatedState();
}

class AuthenticatedState extends AppAuthState {
  const AuthenticatedState({required this.user});
  final UserModel user;

  @override
  List<Object?> get props => [user];

  AuthenticatedState copyWith({UserModel? user}) => AuthenticatedState(user: user ?? this.user);
}

class LoggingOutState extends AppAuthState {
  const LoggingOutState();
}


class LoggedOutState extends AppAuthState {
  const LoggedOutState();
}
