import 'dart:async';

import 'package:currencyconverterapp/APIService/web_api.dart';
import 'package:currencyconverterapp/Helpers/service_locator.dart';
import 'package:currencyconverterapp/Helpers/view_state.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/Model/Rate.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/Service/exchange_service.dart';
import 'package:flutter/cupertino.dart';

class ExchangeViewModel extends ChangeNotifier {
  final ExchangeRateService _exchangeRateService =
      service_locator<ServiceApi>();
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  Rate rate;

  setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<bool> fetchCurrencyRatesFor(String currencyText) {
    setState(ViewState.Busy);
    final completer = Completer<bool>();
    _exchangeRateService.fetchExchangeRatesFor("SEK").then((result) {
      // TODO: Change to Result Type
      if (result != null) {
        rate = result;
        completer.complete(true);
      } else {
        // TODO: Error
        completer.complete(false);
      }
      setState(ViewState.Idle);
    });
    return completer.future;
  }
}
