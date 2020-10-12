
import 'dart:async';

import 'package:currencyconverterapp/APIService/web_api.dart';
import 'package:currencyconverterapp/Helpers/service_locator.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/Model/Rate.dart';
import 'package:currencyconverterapp/Network/networkAPI.dart';
import 'package:currencyconverterapp/Network/networkDataManager.dart';
import 'package:currencyconverterapp/Network/result.dart';

class ExchangeRateService implements ServiceApi {
  final NetworkDataManager _networkDataManager = service_locator<WebServiceApi>();
  @override
  Future<Rate> fetchExchangeRatesFor(String baseCurrency) {
    final completer = Completer<Rate>();
    _networkDataManager.executeGetWith('/latest',queryParameters: {"base": baseCurrency}).then((result) {
      // TODO: check status
      switch (result.status) {
        case ResultStatus.success:
          var rate = Rate.fromJson(result.value);
          print(rate.rates);
          completer.complete(rate);
          break;
        case ResultStatus.error:
          completer.complete(null);
          break;

      }
        //print(result.value);

    });
    return completer.future;
  }

}