import 'package:dio/dio.dart';
import 'package:test_app_2024/core/errors/errors.dart';

Failure mapDioErrorToFailure(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return NetworkFailure(message: error.message ?? 'Network Failure');
    case DioExceptionType.badResponse:
      return ServerFailure(message: error.message ?? 'Server Failure');
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
    default:
      return UnknownFailure(message: error.message ?? 'Unknown ailure');
  }
}
