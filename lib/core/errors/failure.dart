import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDiorError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure('Connection timeout');
      case DioErrorType.sendTimeout:
        return ServerFailure('Send timeout');
      case DioErrorType.receiveTimeout:
        return ServerFailure('Receive timeout');
      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioErrorType.cancel:
        return ServerFailure('Request was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('NO Internet connection');

      case DioErrorType.unknown:
        return ServerFailure('Unexpected error: ${e.message}');
      case DioExceptionType.badCertificate:
        return ServerFailure('bad certificate with Api Server');
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
