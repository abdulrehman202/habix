import 'package:habix/core/Error/ErrorInfo.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  int statusCode;
  ServerFailure({required this.statusCode}) : super(statusCode!.statusCodeErrorMessage);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection detected.');
}

class CacheFailure extends Failure {
  const CacheFailure() : super('Failed to read/write local storage.');
}

class UnknownError extends Failure {
  const UnknownError() : super('Unknown Error Occured');
}

class LoginError extends Failure {
  const LoginError() : super('Invalid Credentials');
}