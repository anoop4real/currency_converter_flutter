import 'package:currencyconverterapp/Network/networkAPI.dart';
import 'package:currencyconverterapp/Network/result.dart';
import 'package:dio/dio.dart';

class NetworkDataManager implements WebServiceApi {
  static const _defaultConnectTimeout = Duration.millisecondsPerMinute;
  static const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

  // TODO: Get it from Environments
  final String baseUrl;
  // Dio client
  Dio _dio = Dio();
  //final List<Interceptor> interceptors; // TODO Implement later

  NetworkDataManager(this.baseUrl) {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
  }
  @override
  Future<Result<dynamic, Exception>> executeGetWith(String url,
      {Map<String, dynamic> queryParameters}) async {
    try {
      var response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
      return Result.success(response.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
      return Result.failure(e);
    }
  }

  @override
  Future<Result<dynamic, Exception>> executePostWith(String url,
      {data, Map<String, dynamic> queryParameters}) async {
    try {
      var response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return Result.success(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
      return Result.failure(e);
    }
  }

  // TODO: Created error handler
}
