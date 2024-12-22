part of 'app_auth_bloc.dart';
abstract class AppAuthState extends Equatable {
  const AppAuthState();

  @override
  List<Object> get props => [];
}

class UnAuthenticatedState extends AppAuthState {
  const UnAuthenticatedState();
}

class AuthenticatedState extends AppAuthState {
  const AuthenticatedState();
}

class LoggingOutState extends AppAuthState {
  const LoggingOutState();
}

class SessionExpiredState extends AppAuthState {
  const SessionExpiredState();
}

class LoggedOutState extends AppAuthState {
  const LoggedOutState();
}

