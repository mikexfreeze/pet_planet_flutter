import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class Fetch extends http.BaseClient{
  http.Client _httpClient = new http.Client();
  String token;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
//    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.get('token');
    return _httpClient.get('$BASE_URL/$url', headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    },);
  }

  @override
  Future<http.Response> post(url, {Map<String, String> headers, body, Encoding encoding}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.get('token');
    return _httpClient.post('$BASE_URL/$url', headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    }, body: body);
  }
}

class TestFetch {
  String token;

  Future<http.Response> fetch(url, body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.get('token');

    final http.Response response = await http.post(
      Uri.parse('$BASE_URL/$url'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: body
    );

    print('response.body, $response.body');
    return response;
  }
}

