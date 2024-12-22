part of 'app_auth_bloc.dart';

abstract class AppAuthEvent extends Equatable {
  const AppAuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthenticationAppEvent extends AppAuthEvent {}

class LogoutAppEvent extends AppAuthEvent {}

class SessionExpiredAppEvent extends AppAuthEvent {}
