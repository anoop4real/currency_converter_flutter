import 'dart:convert';

import 'package:currencyconverterapp/Network/network_api.dart';
import 'package:currencyconverterapp/Network/result.dart';
import 'package:mockito/mockito.dart';

import '../Common/MockResponses/responses.dart';

class MockWebService extends Mock implements WebServiceApi {

  @override
  Future<Result<dynamic, Exception>> executeGetWith(String url,
      {Map<String, dynamic> queryParameters}) async {

    return Result.success(json.decode(currencyRateSuccessResponse()));
  }

}