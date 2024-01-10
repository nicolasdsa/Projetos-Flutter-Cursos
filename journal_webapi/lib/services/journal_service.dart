import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
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

  //TODO: Substituir getURL por getURI
  void register(String content) {
    client.post(Uri.parse(getURL()), body: {'content': content});
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getURL()));
    return response.body;
  }
}
