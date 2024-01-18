import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:journal_webapi_authentication/services/webclient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String url = WebClient.url;
  http.Client client = WebClient().client;

  Future<bool> login({required String email, required String password}) async {
    http.Response response = await client.post(Uri.parse("${url}auth/signin"),
        headers: {'Content-type': 'application/json'},
        body: json.encode({'email': email, 'password': password}));

    if (response.statusCode != 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String message = responseData['message'];

      switch (message) {
        case 'User not found':
          throw UserNotFindException();
        default:
          throw HttpException(message);
      }
    }

    saveUserInfos(response.body);
    return true;
  }

  Future<bool> register(
      {required String email, required String password}) async {
    http.Response response = await client.post(Uri.parse('${url}auth/signup'),
        headers: {'Content-type': 'application/json'},
        body: json.encode({'email': email, 'password': password}));

    if (response.statusCode != 201) {
      throw HttpException(response.body);
    }

    saveUserInfos(response.body);
    return true;
  }

  saveUserInfos(String body) async {
    Map<String, dynamic> responseData = json.decode(body);

    String token = responseData['access_token'];
    String email = responseData['email'];
    String id = responseData['id'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", token);
    prefs.setString("email", email);
    prefs.setString("id", id);
  }
}

class UserNotFindException implements Exception {
  final String message = "Usuário não encontrado";
}
