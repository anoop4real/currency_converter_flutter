import 'dart:async';

import 'package:currencyconverterapp/APIService/web_api.dart';
import 'package:currencyconverterapp/Exceptions/app_exceptions.dart';
import 'package:currencyconverterapp/Helpers/service_locator.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/Model/rate.dart';
import 'package:currencyconverterapp/Network/network_api.dart';
import 'package:currencyconverterapp/Network/network_data_manager.dart';
import 'package:currencyconverterapp/Network/result.dart';

class ExchangeRateService implements ServiceApi {
  final NetworkDataManager _networkDataManager =
      service_locator<WebServiceApi>();
  @override
  Future<Result<Rate, ApplicationException>> fetchExchangeRatesFor(
      String baseCurrency) {
    final completer = Completer<Result<Rate, ApplicationException>>();
    _networkDataManager.executeGetWith('/latest',
        queryParameters: {"base": baseCurrency}).then((result) {
      // TODO: check status
      switch (result.status) {
        case ResultStatus.success:
          var rate = Rate.fromJson(result.value);
          print(rate.rates);
          completer.complete(Result.success(rate));
          break;
        case ResultStatus.error:
          completer.complete(Result.failure(result.error));
          break;
      }
    });
    return completer.future;
  }
}
