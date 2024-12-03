part of 'app_auth_bloc.dart';

@freezed
class AppAuthEvent with _$AppAuthEvent {
  const factory AppAuthEvent.checkAuthentication() = CheckAuthenticationAppEvent;
  const factory AppAuthEvent.logout() = LogoutAppEvent;
  const factory AppAuthEvent.sessionExpired() = SessionExpiredAppEvent;
}
