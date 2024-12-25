import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginInProgress extends LoginState {
  const LoginInProgress();
}

class LoginCompleted extends LoginState {
  const LoginCompleted();
}

class LoginError extends LoginState {
  final Failure failure;
  const LoginError({required this.failure});

  @override
  List<Object> get props => [failure];
}
