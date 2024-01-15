import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    logger.t("Requisição para ${request.url}\nCabeçalho:${request.headers}");
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    if (response.statusCode ~/ 100 == 2) {
      logger.i(
          "Resposta de ${response.request?.url}\n${response.headers}\n${response.statusCode}\n");
    } else {
      logger.e(
          "Resposta de ${response.request?.url}\n${response.headers}\n${response.statusCode}\n");
    }
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return true;
  }
}
