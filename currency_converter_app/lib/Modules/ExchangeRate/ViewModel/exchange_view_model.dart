import 'dart:async';

import 'package:currencyconverterapp/Exceptions/app_exceptions.dart';
import 'package:currencyconverterapp/Helpers/utilities.dart';
import 'package:currencyconverterapp/Network/result.dart';

import '../../../APIService/web_api.dart';
import '../../../Helpers/service_locator.dart';
import '../../../Helpers/view_state.dart';
import '../../../Modules/ExchangeRate/Model/rate.dart';
import '../../../Modules/ExchangeRate/Service/exchange_service.dart';

import 'base_view_model.dart';

class ExchangeViewModel extends BaseViewModel {
  final ExchangeRateService _exchangeRateService =
      service_locator<ServiceApi>();
  List<String> _currencies = [
    'EUR',
    'INR',
    'GBP',
    'USD',
    'HKD',
    'ISK',
    'PHP',
    'DKK',
    'HUF',
    'CZK',
    'AUD',
    'RON',
    'IDR',
    'BRL',
    'RUB',
    'HRK',
    'JPY',
    'THB',
    'CHF',
    'SGD',
    'PLN',
    'BGN',
    'TRY',
    'CNY',
    'NOK',
    'NZD',
    'ZAR',
    'MXN',
    'ILS',
    'KRW',
    'MYR'
  ];
  Rate rate;
  String errorMessage = "";

  Future<bool> fetchCurrencyRatesFor(String amount, String currencyText) {
    setState(ViewState.Busy);
    final completer = Completer<bool>();
    _exchangeRateService.fetchExchangeRatesFor(currencyText).then((result) {
      switch (result.status) {
        case ResultStatus.success:
          rate = computeRatesFor(amount, result.value);
          print(rate.rates.keys);
          completer.complete(true);
          break;
        case ResultStatus.error:
          rate = null;
          ApplicationException exception = result.error;
          errorMessage = exception.toString();
          print(errorMessage);
          completer.complete(false);
          break;
      }
      setState(ViewState.Idle);
    });
    return completer.future;
  }

  List<String> getCurrencyCodes() {
    return _currencies;
  }

  Rate computeRatesFor(String amount, Rate rate) {
    double amountValue = double.tryParse(amount);

    if (amountValue != null) {
      Map<String, double> fetchedRates = Map.from(rate.rates);
      var computedRates = fetchedRates.map((key, value) =>
          MapEntry<String, double>(key, roundDouble((value * amountValue), 2)));
      rate.rates = computedRates;
      return rate;
    } else {
      return rate;
    }
  }
}
