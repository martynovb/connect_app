import 'dart:convert';
import 'package:connect_app/data/api/connect_http_client.dart';
import 'package:connect_app/data/api/model/model_converter.dart';
import 'package:connect_app/data/error_handler.dart';
import 'package:http/http.dart' as http;

class ConnectApi {
  final ConnectHttpClient httpClient;
  final ErrorHandler errorHandler;

  ConnectApi({
    required this.httpClient,
    required this.errorHandler,
  });

  Future<T> get<T>(String path, ModelConverter<T> converter) async {
    return _requestWrapper(
      () => httpClient.get(Uri.parse(path)),
      converter,
    );
  }

  Future<T> post<T>(String path, ModelConverter<T> converter,
      {Map<String, dynamic>? body}) async {
    return _requestWrapper(
      () => httpClient.post(
        Uri.parse(path),
        headers: {'Content-Type': 'application/json'},
        body: body != null ? jsonEncode(body) : null,
      ),
      converter,
    );
  }

  Future<T> _requestWrapper<T>(
    Future<http.Response> Function() request,
    ModelConverter<T> converter,
  ) async {
    try {
      final response = await request();
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return converter.fromJson(jsonData); // Convert JSON to Dart object
      } else {
        throw errorHandler.handleError(response.statusCode, response.body);
      }
    } on FormatException {
      throw ParseException('Failed to parse the response from the server.');
    } catch (e) {
      if (e is ApiException || e is InvalidCredentialsException) {
        rethrow;
      } else {
        throw ApiException('An unexpected error occurred');
      }
    }
  }
}
