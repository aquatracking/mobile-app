import 'package:dio/dio.dart';

class ApiError extends DioException {
  final int statusCode;
  final String code;

  ApiError({
    required super.requestOptions,
    required this.statusCode,
    required this.code,
  });
}
