import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repo/auth_repo.dart';

part 'app_auth_event.dart';
part 'app_auth_state.dart';

@lazySingleton
class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final AuthRepo authRepo;
  AppAuthBloc(this.authRepo) : super(const UnAuthenticatedState()) {
    on<AppAuthEvent>(_mapEvents);
  }

  Future<void> _mapEvents(AppAuthEvent event, Emitter<AppAuthState> emit) async {
    if (event is CheckAuthenticationAppEvent) {
      await _checkAuthentication(emit);
    } else if (event is LogoutAppEvent) {
      await _handleLogout(emit);
    } else if (event is SessionExpiredAppEvent) {
      await _handleSessionExpired(emit);
    }
  }

  Future<void> _checkAuthentication(Emitter<AppAuthState> emit) async {
    emit(authRepo.isAuthenticated ? const AuthenticatedState() : const UnAuthenticatedState());
  }

  Future<void> _handleLogout(Emitter<AppAuthState> emit) async {
    emit(const LoggingOutState());
    await Future.delayed(const Duration(seconds: 2));
    await authRepo.logout();
    emit(const LoggedOutState());
  }

  Future _handleSessionExpired(Emitter<AppAuthState> emit) async {
    emit(const SessionExpiredState());
    await authRepo.logout();
    await Future.delayed(const Duration(seconds: 3));
    emit(const LoggedOutState());
  }
}
