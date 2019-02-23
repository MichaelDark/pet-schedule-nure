import 'package:http/http.dart' as http;
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:meta/meta.dart';
import 'package:nure_schedule/api/util/api_client_exception.dart';
import 'package:nure_schedule/api/util/parser.dart';

const String textUnknownException = 'Unknown Exception';
const String _tag = '<<<ResponseHandler>>>:';

typedef bool Validator<T>(T data);

class ResponseExtractor {
  ResponseExtractor._();

  static void _log(http.Response response, [ApiClientException exception]) {
    http.Request request = response.request;
    print('$_tag ${request.method} ${request.url} ${exception?.message ?? response.body}');
  }

  static bool _isStatusCodeSuccess(int statusCode) {
    return statusCode == 200 || statusCode == 201;
  }

  static Future<ParsedType> _extractData<SerializableType, ParsedType>({
    @required http.Response response,
    @required Serializer<SerializableType> serializer,
    @required IParser<SerializableType, ParsedType> parser,
    @required bool canBeNull,
    @nullable Validator<ParsedType> validator,
  }) async {
    _log(response);
    try {
      ParsedType parsedData = parser.parse(response.body, serializer);

      bool isStatusCodeOk = _isStatusCodeSuccess(response.statusCode);
      bool matchNullCondition = parsedData == null ? canBeNull : true;
      bool isValid = validator != null ? validator(parsedData) : true;

      if (isStatusCodeOk && isValid && matchNullCondition) {
        return parsedData;
      }
    } catch (ignored) {
      print(ignored);
    }

    ApiClientException exception = _parseError(response);
    return Future.error(exception);
  }

  static ApiClientException _parseError(http.Response response) {
    ApiClientException exception = ApiClientException(
      statusCode: response.statusCode,
      message: response.body ?? textUnknownException,
    );

    _log(response, exception);

    return exception;
  }

  static Future<T> extractItem<T>(
    http.Response response,
    Serializer<T> serializer, {
    bool canBeNull = false,
    @nullable Validator<T> validator,
  }) async {
    return _extractData<T, T>(
      response: response,
      serializer: serializer,
      parser: ItemParser<T>(),
      validator: validator,
      canBeNull: canBeNull,
    );
  }

  static Future<List<T>> extractList<T>(
    http.Response response,
    Serializer<T> serializer, {
    bool canBeNull = false,
    @nullable Validator<List<T>> validator,
  }) async {
    return _extractData<T, List<T>>(
      response: response,
      serializer: serializer,
      parser: ListParser<T>(),
      validator: validator,
      canBeNull: canBeNull,
    );
  }

  static Future<void> extract(http.Response response) async {
    _log(response);

    bool isStatusCodeOk = _isStatusCodeSuccess(response.statusCode);

    if (!isStatusCodeOk) {
      ApiClientException exception = _parseError(response);
      return Future.error(exception);
    }
  }
}
