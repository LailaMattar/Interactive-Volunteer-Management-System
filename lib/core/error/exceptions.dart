import 'package:takatof/core/error/error_model.dart';

class ServerException implements Exception{
  final ErrorModel errorModel;

  ServerException({
    required this.errorModel
  });
}

class AppException implements Exception{
  final ErrorModel errorModel;

  AppException({required this.errorModel});
}