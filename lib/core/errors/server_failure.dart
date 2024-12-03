import 'failures.dart';

// **************************************************************************
//
// ----- Server Failures
//
// The codes represents the network response codes to be mapped with custom error messages
//

class BadRequestFailure extends ServerFailure {
  const BadRequestFailure({super.message}) : super(code: 400);
}

class UnauthorizedFailure extends ServerFailure {
  const UnauthorizedFailure([String? message]) : super(code: 401, message: message);
}

class ForbiddenFailure extends ServerFailure {
  const ForbiddenFailure() : super(code: 403);
}

class NotFoundFailure extends ServerFailure {
  const NotFoundFailure() : super(code: 404);
}

class InternalServerFailure extends ServerFailure {
  const InternalServerFailure({super.message}) : super(code: 500);
}

class BadGatewayFailure extends ServerFailure {
  const BadGatewayFailure() : super(code: 502);
}

class ServiceUnavailableFailure extends ServerFailure {
  const ServiceUnavailableFailure() : super(code: 503);
}

class GatewayTimeoutFailure extends ServerFailure {
  const GatewayTimeoutFailure() : super(code: 504);
}

class TeapotFailure extends ServerFailure {
  const TeapotFailure() : super(code: 418);
}

class BadCertificateFailure extends ServerFailure {
  const BadCertificateFailure() : super(code: 1);
}
//
// **************************************************************************

// **************************************************************************
//
// ----- Client Failures
//
// The codes represents custom codes to be mapped with custom error messages
//
class SendTimeoutFailure extends ClientFailure {
  const SendTimeoutFailure({super.message}) : super(code: 1);
}

class ReceiveTimeoutFailure extends ClientFailure {
  const ReceiveTimeoutFailure({super.message}) : super(code: 2);
}

class ConnectionTimeoutFailure extends ClientFailure {
  const ConnectionTimeoutFailure({super.message}) : super(code: 3);
}

class ConnectionErrorFailure extends ClientFailure {
  const ConnectionErrorFailure({super.message}) : super(code: 4);
}

class RequestCanceledFailure extends ClientFailure {
  const RequestCanceledFailure({super.message}) : super(code: 5);
}
//
// **************************************************************************

// **************************************************************************
//
// ----- Generic Failures
//
class MappingDataFailure extends Failure {
  const MappingDataFailure() : super();
}

class ApiFailure extends Failure {
  const ApiFailure({super.message}) : super();
}
//
// **************************************************************************