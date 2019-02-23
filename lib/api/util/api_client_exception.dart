import 'package:meta/meta.dart';

class ApiClientException {
  final int statusCode;
  final String message;

  ApiClientException({
    @required this.statusCode,
    @required this.message,
  });
}
