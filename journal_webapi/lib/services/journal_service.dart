import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:journal_webapi/services/http_interceptors.dart';

class JournalService {
  static const String url = "/";
  static const String resource = "learnhttp/";

  String getURL() {
    return "$url$resource";
  }

  //TODO: Substituir getURL por getURI
  void register(String content) {
    http.post(Uri.parse(getURL()), body: {'content': content});
  }

  void get() async {}
}
