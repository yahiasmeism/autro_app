part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegistrationInProgress extends RegisterState {
  const RegistrationInProgress();
}

class RegistrationCompleted extends RegisterState {
  const RegistrationCompleted();
}

class RegisterError extends RegisterState {
  final Failure failure;
  const RegisterError({required this.failure});

  @override
  List<Object> get props => [failure];
}
