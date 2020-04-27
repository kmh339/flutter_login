import 'dart:convert';
import 'dart:async';
import 'package:flutter_login/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class AmuseApiClient {
  static const baseUrl = 'http://dev.amusetravel.com';
  final _httpClient = http.Client();
  final _userRepository = UserRepository();


  Future<dynamic> get(String url) async {
    String accessToken = await _userRepository.getAccessToken();

    if (accessToken != null) {
      print("]-----] apiUrl + url [-----[ ${baseUrl + url}");
      final response = await _httpClient.get(baseUrl + url, headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Authorization': accessToken
      });
      print(
          "]-----] AmuseApiClient Future get : response [-----[ ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 500) {
        if (response.body != null) {
          return json.decode(utf8.decode(response.bodyBytes));
        } else {
          return null;
        }
      } else if (response.statusCode == 401) {
        return null;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Error fetching get');
      }
    } else {
      throw Exception('Error accessToken is null');
    }
  }

  Future<dynamic> post(String url, String body) async {
    String accessToken = await _userRepository.getAccessToken();

    if (accessToken != null) {
      final response = await _httpClient.post(baseUrl + url,
          headers: {
            'Content-Type': 'application/json',
            "Authorization": accessToken
          },
          body: body);

      print("]-----] AmuseApiClient Future post : response [-----[ ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 500) {
        return json.decode(utf8.decode(response.bodyBytes));
      } else if (response.statusCode == 401) {
        return null;
      } else {
        var result = json.decode(response.body);
        throw Exception('Error in post : $result');
      }
    } else {
      throw Exception('Error accessToken is null');
    }
  }

  Future<dynamic> postForLogin(String url, String body) async {
    print(']-------] postWithoutAuth : body [-------[ ${baseUrl + url}');
    final response = await _httpClient.post(baseUrl + url,
        headers: {'Content-Type': 'application/json'}, body: body);

    Map<String, dynamic> jsonBody =
    json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200 || response.statusCode == 500) {
      await _userRepository.persistToken(jsonBody['accessToken']);
      return jsonBody;
    } else {
      throw Exception('Error postForLogin statusCode : ${response.statusCode}');
    }
  }
}
