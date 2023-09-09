import 'dart:convert';
import 'package:connect_app/data/api/connect_http_client.dart';
import 'package:connect_app/data/error_handler.dart';
import 'package:http/http.dart' as http;

class ConnectApi {
  final ConnectHttpClient httpClient;
  final ErrorHandler errorHandler;

  ConnectApi({
    required this.httpClient,
    required this.errorHandler,
  });

  Future<dynamic> get(String path) async {
    return _requestWrapper(() => httpClient.get(Uri.parse(path)));
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    return _requestWrapper(() => httpClient.post(
          Uri.parse(path),
          headers: {'Content-Type': 'application/json'},
          body: body != null ? jsonEncode(body) : null,
        ));
  }

  Future<dynamic> _requestWrapper<T>(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
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
