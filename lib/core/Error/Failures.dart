// lib/core/errors/failures.dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({this.statusCode}) : super('A server error occurred.');
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection detected.');
}

class CacheFailure extends Failure {
  const CacheFailure() : super('Failed to read/write local storage.');
}