import 'dart:io';

import '../Exceptions/app_exceptions.dart';
import '../Exceptions/exception_types.dart';
import '../Network/network_api.dart';
import '../Network/result.dart';
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
      print(response.data);
      return Result.success(response.data);
    } catch (e) {
      ApplicationException exception = handleException(e);
      return Result.failure(exception);
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
    } catch (e) {
      ApplicationException exception = handleException(e);
      return Result.failure(exception);
    }
  }

  static ApplicationException handleException(error) {
    if (error is Exception) {
      try {
        ApplicationException exception;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.CANCEL:
              exception = ApplicationException(ExceptionType.requestCancelled);
              break;
            case DioErrorType.CONNECT_TIMEOUT:
              exception = ApplicationException(ExceptionType.requestTimeout);
              break;
            case DioErrorType.DEFAULT:
              exception =
                  ApplicationException(ExceptionType.noInternetConnection);
              break;
            case DioErrorType.RECEIVE_TIMEOUT:
              exception = ApplicationException(ExceptionType.timeout);
              break;
            case DioErrorType.RESPONSE:
              switch (error.response.statusCode) {
                case 400:
                  exception = ApplicationException(ExceptionType.badRequest);
                  break;
                case 401:
                  exception =
                      ApplicationException(ExceptionType.unauthorisedRequest);
                  break;
                case 403:
                  exception =
                      ApplicationException(ExceptionType.unauthorisedRequest);
                  break;
                case 404:
                  exception = ApplicationException(ExceptionType.notFound);
                  break;
                case 409:
                  exception = ApplicationException(ExceptionType.unknownError);
                  break;
                case 408:
                  exception =
                      ApplicationException(ExceptionType.requestTimeout);
                  break;
                case 500:
                  exception =
                      ApplicationException(ExceptionType.internalServerError);
                  break;
                case 503:
                  exception =
                      ApplicationException(ExceptionType.serviceUnavailable);
                  break;
                default:
                  exception = ApplicationException(ExceptionType.unknownError);
              }
              break;
            case DioErrorType.SEND_TIMEOUT:
              exception = ApplicationException(ExceptionType.timeout);
              break;
          }
        } else if (error is SocketException) {
          exception = ApplicationException(ExceptionType.noInternetConnection);
        } else {
          exception = ApplicationException(ExceptionType.unknownError);
        }
        return exception;
      } on FormatException catch (e) {
        return ApplicationException(ExceptionType.formatException);
      } catch (_) {
        return ApplicationException(ExceptionType.unknownError);
      }
    } else {
      return ApplicationException(ExceptionType.unknownError);
    }
  }
}
