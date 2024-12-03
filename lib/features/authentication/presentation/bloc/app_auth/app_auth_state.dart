part of 'app_auth_bloc.dart';

@freezed
class AppAuthState with _$AppAuthState {
  const factory AppAuthState.unAuthenticated() = UnAuthenticatedState;
  const factory AppAuthState.authenticated() = AuthenticatedState;
  const factory AppAuthState.loggingOut() = LoggingOutState;
  const factory AppAuthState.sessionExpired() = SessionExpiredState;
  const factory AppAuthState.loggedOut() = LoggedOutState;
}
