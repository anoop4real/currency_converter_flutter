import 'dart:convert';

import 'package:currencyconverterapp/Exceptions/app_exceptions.dart';
import 'package:currencyconverterapp/Exceptions/exception_types.dart';
import 'package:currencyconverterapp/Network/network_api.dart';
import 'package:currencyconverterapp/Network/result.dart';
import 'package:mockito/mockito.dart';

import '../Common/MockResponses/responses.dart';

class MockWebService extends Mock implements WebServiceApi {

  bool isFailure;
  MockWebService({this.isFailure});
  @override
  Future<Result<dynamic, Exception>> executeGetWith(String url,
      {Map<String, dynamic> queryParameters}) async {

    print(isFailure);
    if(isFailure) {
      return Result.failure(ApplicationException(ExceptionType.unknownError));
    } else {
      return Result.success(json.decode(currencyRateSuccessResponse()));
    }
  }

}