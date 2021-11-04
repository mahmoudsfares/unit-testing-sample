import 'dart:convert';
import 'package:http/http.dart' as http;


class MyHttpClient {

  final String _baseUrl = 'https://jsonplaceholder.typicode.com/';

  Future<http.Response> get({Map<String, String>? params}) {
    var url = Uri.http(_baseUrl, 'todos/', params);
    return http.get(url).timeout(Duration(seconds: 10));
  }

  Future<http.Response> post<T>(String endpointUrl, T body) {
    var url = Uri.http(_baseUrl, endpointUrl);
    return http.post(
        url, headers: {"Content-Type": "application/json"},
        body: jsonEncode(body)).timeout(Duration(seconds: 10));
  }
}
