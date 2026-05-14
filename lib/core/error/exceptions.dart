class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});
}

class UnexpectedException implements Exception {
  final String message;

  UnexpectedException({required this.message});
}
