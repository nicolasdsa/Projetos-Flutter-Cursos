import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:journal_webapi_authentication/services/webclient.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/journal.dart';

class JournalService {
  static const String resource = "journals/";
  String url = WebClient.url;
  http.Client client = WebClient().client;

  String getURL() {
    return "$url$resource";
  }

  Uri getUri() {
    return Uri.parse(getURL());
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? null;
  }

  Future<bool> register(Journal journal) async {
    String? token = await getToken();
    String journalJSON = json.encode(journal.toMap());

    http.Response response = await client.post(
      getUri(),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: journalJSON,
    );

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }

    if (response.statusCode != 201) {
      throw HttpException(response.body);
    }

    return true;
  }

  Future<bool> edit(String id, Journal journal) async {
    journal.updatedAt = DateTime.now();
    String? token = await getToken();
    String journalJSON = json.encode(journal.toMap());

    http.Response response = await client.put(
      Uri.parse("${getUri()}$id"),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: journalJSON,
    );

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }

    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }

    return true;
  }

  Future<bool> remove(String id) async {
    String? token = await getToken();
    http.Response response = await http.delete(
      Uri.parse("${getUri()}$id"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }

    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }

    return true;
  }

  Future<List<Journal>> getAll(
      {required String? id, required String? token}) async {
    //String? token = await getToken();
    http.Response response = await client.get(
      getUri(),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }

    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }

    List<Journal> result = [];

    List<dynamic> jsonList = json.decode(response.body);
    for (var jsonMap in jsonList) {
      result.add(Journal.fromMap(jsonMap));
    }

    return result;
  }
}

class UnauthorizedException implements Exception {
  final String message = "Usuário não autorizado";
}
