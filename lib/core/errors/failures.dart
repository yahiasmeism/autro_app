import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});
  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  final int code;

  const ServerFailure({required this.code, super.message});

  @override
  List<Object> get props => [code];
}

class ClientFailure extends Failure {
  final int code;

  const ClientFailure({required this.code, super.message});

  @override
  List<Object> get props => [code];
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({super.message});
}

class GeneralFailure extends Failure {
  const GeneralFailure({super.message});
}
