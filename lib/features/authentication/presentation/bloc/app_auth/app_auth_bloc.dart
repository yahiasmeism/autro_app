import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repo/auth_repo.dart';

part 'app_auth_event.dart';
part 'app_auth_state.dart';
part 'app_auth_bloc.freezed.dart';

@lazySingleton
class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final AuthRepo authRepo;
  AppAuthBloc(this.authRepo) : super(const AppAuthState.unAuthenticated()) {
    on<AppAuthEvent>(_mapEvents);
  }

  Future<void> _mapEvents(AppAuthEvent event, Emitter<AppAuthState> emit) async {
    await event.when(
      checkAuthentication: () async => await _checkAuthentication(emit),
      logout: () async => await _handleLogout(emit),
      sessionExpired: () async => await _handleSessionExpired(emit),
    );
  }

  Future<void> _checkAuthentication(Emitter<AppAuthState> emit) async {
    emit(authRepo.isAuthenticated ? const AppAuthState.authenticated() : const AppAuthState.unAuthenticated());
  }

  Future<void> _handleLogout(Emitter<AppAuthState> emit) async {
    emit(const AppAuthState.loggingOut());
    await Future.delayed(const Duration(seconds: 2));
    await authRepo.logout();
    emit(const AppAuthState.loggedOut());
  }

  Future _handleSessionExpired(Emitter<AppAuthState> emit) async {
    emit(const AppAuthState.sessionExpired());
    await authRepo.logout();
    await Future.delayed(const Duration(seconds: 3));
    emit(const AppAuthState.loggedOut());
  }
}
