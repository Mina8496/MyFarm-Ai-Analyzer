import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('NO Internet connection');
      case DioExceptionType.unknown:
        return ServerFailure('Unexpected error: ${e.message}');
      case DioExceptionType.badCertificate:
        return ServerFailure('bad certificate with Api Server');
      case DioExceptionType.transformTimeout:
        return ServerFailure('check your Internet connection');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure('Not found');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['message'] ?? 'Authentication error');
    } else {
      return ServerFailure('Received invalid status code: $statusCode');
    }
  }
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
