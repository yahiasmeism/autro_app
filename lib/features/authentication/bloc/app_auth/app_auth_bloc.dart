import 'dart:async';

import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/constants/hive_keys.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/extensions/hive_box_type_extension.dart';
import 'package:autro_app/core/utils/logger_util.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../data/repo/auth_repo.dart';

part 'app_auth_event.dart';
part 'app_auth_state.dart';

@lazySingleton
class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final AuthRepo authRepo;
  AppAuthBloc(this.authRepo) : super(const InitialAppAuthState()) {
    on<AppAuthEvent>(_mapEvents);
  }
  final box = Hive.box(HiveBoxType.user.boxName);

  Future<void> _mapEvents(AppAuthEvent event, Emitter<AppAuthState> emit) async {
    if (event is CheckAuthenticationAppEvent) {
      await _checkAuthentication(emit);
    }
    if (event is LogoutAppEvent) {
      await _handleLogout(emit);
    }
    if (event is AuthenticatedAppEvent) {
      _authenticateUser(event.user, emit);
    }
  }

  Future<void> _checkAuthentication(Emitter<AppAuthState> emit) async {
    if (authRepo.isAuthenticated) {
      await _getUser(emit);
    } else {
      emit(const UnAuthenticatedState());
    }
  }

  _getUser(Emitter<AppAuthState> emit) async {
    try {
      UserModel? userModel = box.get(HiveKeys.userKey);

      if (userModel == null) {
        final either = await authRepo.getUser();
        either.fold(
          (_) => emit(const UnAuthenticatedState()),
          (user) => _authenticateUser(user, emit),
        );
      } else {
        _authenticateUser(userModel, emit);
      }
    } catch (e) {
      LoggerUtils.e(e.toString());
      emit(const UnAuthenticatedState());
    }
  }

  void _authenticateUser(UserModel user, Emitter<AppAuthState> emit) {
    if (sl.isRegistered<UserModel>()) {
      sl.unregister<UserModel>();
    }

    sl.registerLazySingleton<UserModel>(() => user);

    box.put(HiveKeys.userKey, user);

    emit(AuthenticatedState(user: user));
  }

  Future<void> _handleLogout(Emitter<AppAuthState> emit) async {
    emit(const LoggingOutState());
    await Future.delayed(const Duration(seconds: 1));
    await authRepo.logout();
    emit(const LoggedOutState());
  }
}
