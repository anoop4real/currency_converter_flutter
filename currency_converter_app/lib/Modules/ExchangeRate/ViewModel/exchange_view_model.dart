import 'package:currencyconverterapp/APIService/web_api.dart';
import 'package:currencyconverterapp/Helpers/service_locator.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/Model/Rate.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/Service/exchange_service.dart';
import 'package:flutter/cupertino.dart';

class ExchangeViewModel extends ChangeNotifier {
  final ExchangeRateService _exchangeRateService =
      service_locator<ServiceApi>();

  Rate rate;

  fetchCurrencyRatesFor(String currencyText) {
    _exchangeRateService.fetchExchangeRatesFor("INR").then((result) {
      // TODO: Change to Result Type
      if (result != null) {
        rate = result;
      } else {
        // TODO: Error
      }
      notifyListeners();
    });
  }
}
