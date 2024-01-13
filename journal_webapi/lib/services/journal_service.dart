import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:journal_webapi/models/journal.dart';
import 'package:journal_webapi/services/http_interceptors.dart';

class JournalService {
  static const String url = String.fromEnvironment('SERVER_URL');
  static const String resource = "journals/";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  String getURL() {
    return "$url$resource";
  }

  Future<bool> register(Journal journal) async {
    //String jsonJournal = json.encode(journal.toMap());
    print(journal.content.toString());
    http.Response response = await client.post(Uri.parse(getURL()),
        body: {'content': journal.content.toString()});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getURL()));
    return response.body;
  }
}
