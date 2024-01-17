import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:journal_webapi_authentication/services/http_interceptors.dart';

class AuthService {
  static const String url = "http://10.0.2.2:3000";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  Future<bool> login({required String email, required String password}) async {
    http.Response response = await client.post(Uri.parse('$url/auth/signin'),
        headers: {'Content-type': 'application/json'},
        body: json.encode({'email': email, 'password': password}));

    Map<String, dynamic> responseData = json.decode(response.body);
    String message = responseData['message'];

    if (response.statusCode != 202) {
      switch (message) {
        case 'User not found':
          throw UserNotFindException();
        default:
          throw HttpException(message);
      }
    }

    return true;
  }

  register({required String email, required String password}) async {
    http.Response response = await client.post(Uri.parse('$url/auth/signup'),
        headers: {'Content-type': 'application/json'},
        body: json.encode({'email': email, 'password': password}));
  }
}

class UserNotFindException implements Exception {
  final String message = "Usuário não encontrado";
}
