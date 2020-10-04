import 'package:currencyconverterapp/Network/result.dart';

abstract class WebServiceApi {

  Future<Result<dynamic, Exception>> executeGetWith(String url,
      {Map<String, dynamic> queryParameters});

  Future<Result<dynamic, Exception>> executePostWith(String url,
      {data, Map<String, dynamic> queryParameters});
}
